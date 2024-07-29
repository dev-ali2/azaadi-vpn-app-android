import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/controller/splash_controller.dart';
import 'package:get/get.dart';

class InitControllers {
  static void initControllers() {
    Get.put(permanent: true, PremiumController());
    Get.put(permanent: true, HapticController());
    Get.put(permanent: true, NotificationController());
    Get.put(permanent: true, HiveController());
    Get.put(permanent: true, ConnectionController());
    Get.put(permanent: true, SplashController());
    Get.put(permanent: true, AdController());
    Get.put(permanent: true, ColorController());
  }
}
