import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/app_consts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PurchaseService {
  static final PurchaseService instance = PurchaseService._internal();
  bool isPro = false;

  PurchaseService._internal() {
    _initPlatformState();
  }

  static void processAfterPayment(
    Function() callback,
    BuildContext context,
  ) async {
    if (PurchaseService.instance.isPro || kDebugMode) {
      callback();
    } else {
      await RevenueCatUI.presentPaywallIfNeeded(AppConsts.revenueEntitlement);
    }
  }

  Future<void> _initPlatformState() async {
    await Purchases.restorePurchases();
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    isPro = customerInfo.entitlements.all.isNotEmpty;

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      isPro = customerInfo.entitlements.active.isNotEmpty;
    });
  }
}
