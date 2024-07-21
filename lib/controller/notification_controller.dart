import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  Rx<bool> isNotificationsEnabled = HiveController.getShowNotification.obs;

  Future<bool> checkAndAskPermissions() async {
    bool isAllow = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllow) {
      final b =
          await AwesomeNotifications().requestPermissionToSendNotifications();

      isAllow = b;
    }
    return isAllow;
  }

  void changeNotificationPref(bool b) async {
    bool permissions = await checkAndAskPermissions();
    if (permissions) {
      HiveController.setShowNotification = b;
      isNotificationsEnabled.value = b;
    }
  }

  static void initNotificationService() async {
    await AwesomeNotifications()
        .initialize('resource://drawable/android12splash', [
      NotificationChannel(
          channelKey: 'connection_status',
          channelName: 'Connection Status',
          channelDescription:
              'This channel will show connection related notifications',
          channelGroupKey: 'basic',
          playSound: false)
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic', channelGroupName: 'General')
    ]);
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreateMethod(
      ReceivedNotification r) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification r) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction a) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction a) async {}

  static void showNotification(String title, String body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 0, channelKey: 'connection_status', title: title, body: body));
  }
}
