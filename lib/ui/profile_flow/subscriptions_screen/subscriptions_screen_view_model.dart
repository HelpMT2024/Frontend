import 'package:help_my_truck/const/app_consts.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/services/purchase_service.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:rxdart/rxdart.dart';

enum SubscriptionPeriod {
  annual,
  monthly,
  freeTrial,
}

class SubscriptionInfo {
  final SubscriptionPeriod? currentPeriod;
  final String? since;
  final String? renewal;

  SubscriptionInfo({
    required this.currentPeriod,
    required this.since,
    required this.renewal,
  });
}

class SubscriptionsScreenViewModel {
  late final info = BehaviorSubject<SubscriptionInfo>()
    ..addStream(
      Stream.fromFuture(_getSubscriptionInfo()),
    );

  final ProfileProvider provider;

  bool get isSubscribed => PurchaseService.instance.isPro;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  SubscriptionsScreenViewModel({required this.provider});

  Future<void> subscribe() async {
    await RevenueCatUI.presentPaywallIfNeeded(AppConsts.revenueEntitlement);
  }

  void restore() {
    isLoading.add(true);
    try {
      Purchases.restorePurchases().then(
        (value) {
          isLoading.add(false);
        },
      );
    } catch (e) {
      isLoading.add(false);
    }
  }

  Future<SubscriptionInfo> _getSubscriptionInfo() async {
    final customerInfo = await Purchases.getCustomerInfo();
    final date = customerInfo.originalPurchaseDate;
    if (date == null) {
      return SubscriptionInfo(currentPeriod: null, since: null, renewal: null);
    }
    final purchaseDate = DateTime.parse(date);
    final active = customerInfo.entitlements.active.values.firstOrNull;

    if (active == null) {
      return SubscriptionInfo(currentPeriod: null, since: null, renewal: null);
    }

    final end = DateTime.parse(active.expirationDate ?? '');
    final format = DateFormat('MMM dd, yyyy');
    final since = format.format(purchaseDate);

    final period = active.productIdentifier == 'annual'
        ? SubscriptionPeriod.annual
        : SubscriptionPeriod.monthly;

    final type = active.periodType == PeriodType.normal
        ? period
        : SubscriptionPeriod.freeTrial;

    final renewal = format.format(end);

    return SubscriptionInfo(
      currentPeriod: type,
      since: since,
      renewal: renewal,
    );
  }
}
