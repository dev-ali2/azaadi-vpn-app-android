import 'dart:developer';

import 'package:azaadi_vpn_android/controller/hive_controller.dart';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PremiumController extends GetxController {
  // static PurchasesConfiguration? configuration;
  Rx<bool> isPremium = HiveController.getIsPremium.obs;

  void changePremiumStatus(bool value) {
    HiveController.setIsPremium = value;
    isPremium.value = value;
  }

  static Future<void> initInAppPurchases() async {}
  // static Future<void> initInAppPurchasesRevenueCat() async {
  //   await Purchases.setLogLevel(LogLevel.debug);
  //   configuration = PurchasesConfiguration('goog_JTwpbaOsDOwMiRBWcaSgaxSmkjP');
  //   await Purchases.configure(configuration!);
  // }

  static Future<void> listenToPurchasesInStore(
      List<PurchaseDetails> details) async {
    // details.forEach((element) { }); use this if you have a list of products in store
    if (details.first.pendingCompletePurchase) {
      await InAppPurchase.instance.completePurchase(details.first);
    }
    if (details.first.status == PurchaseStatus.purchased ||
        details.first.status == PurchaseStatus.restored) {
      log('Yoo you bought it');
    }
    if (details.first.status == PurchaseStatus.error) {
      log('There is an error buying');
    }
    if (details.first.status == PurchaseStatus.canceled) {
      log('Purchase cancelled');
    }
  }
}
