import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/widgets/custom_switch.dart';
import 'package:azaadi_vpn_android/widgets/listView_subtitle.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/permission_promt_dialog.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class NotificationsOption extends StatelessWidget {
  const NotificationsOption({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();
    final hapticController = Get.find<HapticController>();

    return Obx(() => SettingsOptionTile(
          leading: Icon(
            Icons.notifications,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          listViewSubtitle: ListViewSubtitle(
            text:
                'Enable this to see vpn connection status in notification bar',
          ),
          listViewTitle: ListViewTitle(
            text: 'Connection Info',
          ),
          trailing: CustomSwitch(
            onChanged: (value) async {
              hapticController.provideFeedback(FeedbackType.medium);
              bool isInitial = await HiveController.getIsInitialNotification;
              if (isInitial) {
                HiveController.setIsInitialNotification = false;
                Get.to(
                    transition: Transition.fadeIn,
                    () => PermissionsPromtDialog(
                        description:
                            'This option will allow the app to send you connection related notifications\nYou can easily allow or deny this permission from the system dialog the next time you will try to enable this option ',
                        type: 'Send notifications'));
              } else {
                notificationController.changeNotificationPref(value);
              }
            },
            value: notificationController.isNotificationsEnabled.value,
          ),
        ));
  }
}
