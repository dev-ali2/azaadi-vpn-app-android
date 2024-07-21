import 'dart:async';
import 'dart:ffi';

import 'package:get/get.dart';

class StatsController extends GetxController {
  static Rx<bool> isEncrypted = false.obs;
  static Rx<bool> startTimer = false.obs;

  static set setEncryptionStatus(bool value) => isEncrypted.value = value;
  static set setTimerStatus(bool value) => startTimer.value = value;

  static bool get timerStatus => startTimer.value;
  static bool get encryptionStatus => isEncrypted.value;
}
