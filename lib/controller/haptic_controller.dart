import 'package:azaadi_vpn_android/controller/hive_controller.dart';

import 'package:get/get.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticController extends GetxController {
  Rx<bool> isHapticEnabled = HiveController.getHapticStatus.obs;
  void changeHapticSettings(bool value) {
    HiveController.setHapticValue = value;
    isHapticEnabled.value = value;
  }

  bool hapticValue() {
    final getHapticStatus = HiveController.getHapticStatus;
    isHapticEnabled.value = getHapticStatus;
    return getHapticStatus;
  }

  void provideFeedback(FeedbackType f) {
    final getHapticStatus = HiveController.getHapticStatus;
    isHapticEnabled.value = getHapticStatus;
    if (isHapticEnabled.value) {
      Vibrate.feedback(f);
    }
  }
}
