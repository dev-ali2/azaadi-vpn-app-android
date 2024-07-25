import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/controller/splash_controller.dart';
import 'package:get/get.dart';

class InitControllers {
  static void initControllers() {
    Get.put(PremiumController());
    Get.put(HapticController());
    Get.put(NotificationController());
    Get.put(HiveController());
    Get.put(ConnectionController());
    Get.put(SplashController());
    Get.put(AdController());
  }
}
