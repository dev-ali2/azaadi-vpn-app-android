import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/pages/about_page_settings.dart';
import 'package:azaadi_vpn_android/widgets/listView_subtitle.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AboutOption extends StatelessWidget {
  const AboutOption({super.key});

  @override
  Widget build(BuildContext context) {
    final hapticController = Get.find<HapticController>();
    return InkWell(
        onTap: () async {
          hapticController.provideFeedback(FeedbackType.light);

          Get.to(transition: Transition.cupertino, () => AboutPageSettings());
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Theme.of(context).colorScheme.onSecondary,
        child: SettingsOptionTile(
            leading: Icon(
              LucideIcons.badgeInfo,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            listViewSubtitle: ListViewSubtitle(text: 'App info'),
            listViewTitle: ListViewTitle(text: 'About')));
  }
}
