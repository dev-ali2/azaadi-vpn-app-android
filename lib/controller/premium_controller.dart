import 'package:azaadi_vpn_android/controller/hive_controller.dart';

import 'package:get/get.dart';

class PremiumController extends GetxController {
  Rx<bool> isPremium = HiveController.getIsPremium.obs;

  void changePremiumStatus(bool value) {
    HiveController.setIsPremium = value;
    isPremium.value = value;
  }
}
