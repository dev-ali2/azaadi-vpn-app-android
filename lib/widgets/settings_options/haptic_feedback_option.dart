import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/widgets/custom_switch.dart';
import 'package:azaadi_vpn_android/widgets/listView_subtitle.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HapticFeedbackOption extends StatelessWidget {
  const HapticFeedbackOption({super.key});

  @override
  Widget build(BuildContext context) {
    final hapticController = Get.find<HapticController>();
    return Obx(() => SettingsOptionTile(
          leading: Icon(
            LucideIcons.vibrate,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
          trailing: CustomSwitch(
            value: hapticController.isHapticEnabled.value,
            onChanged: (value) {
              hapticController.changeHapticSettings(value);
              hapticController.provideFeedback(FeedbackType.medium);
            },
          ),
          listViewTitle: ListViewTitle(text: 'Haptic Feedback'),
          listViewSubtitle:
              ListViewSubtitle(text: 'Change app haptic behaviour'),
        ));
  }
}
