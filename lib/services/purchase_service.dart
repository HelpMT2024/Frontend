import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService {
  static final PurchaseService instance = PurchaseService._internal();
  bool isPro = false;

  PurchaseService._internal() {
    _initPlatformState();
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
