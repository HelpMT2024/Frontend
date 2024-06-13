import 'package:help_my_truck/const/app_consts.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/services/purchase_service.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionInfo {
  final String currentPeriod;
  final String since;
  final String renewal;

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

  SubscriptionsScreenViewModel({required this.provider});

  Future<void> subscribe() async {
    await RevenueCatUI.presentPaywallIfNeeded(AppConsts.revenueEntitlement);
  }

  Future<void> restore() async {
    await Purchases.restorePurchases();
  }

  Future<SubscriptionInfo> _getSubscriptionInfo() async {
    final customerInfo = await Purchases.getCustomerInfo();
    final purchaseDate = DateTime.parse(
      customerInfo.originalPurchaseDate ?? '',
    );
    final active = customerInfo.entitlements.active.values.firstOrNull;

    final end = DateTime.parse(active?.expirationDate ?? '');
    final format = DateFormat('MMM dd, yyyy');
    final since = format.format(purchaseDate);

    final period = active?.productIdentifier == 'annual' ? 'Annual' : 'Monthly';

    final type =
        active?.periodType == PeriodType.normal ? period : 'Free Trial';

    final renewal = format.format(end);

    return SubscriptionInfo(
      currentPeriod: type,
      since: since,
      renewal: renewal,
    );
  }
}
