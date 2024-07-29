import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/widgets/listView_subtitle.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportBugOption extends StatelessWidget {
  const ReportBugOption({super.key});

  @override
  Widget build(BuildContext context) {
    final hapticController = Get.find<HapticController>();
    return InkWell(
        onTap: () async {
          hapticController.provideFeedback(FeedbackType.light);
          final subject = 'Facing_some_issues_in_Azaadi_Vpn';
          final url = Uri(
              scheme: 'mailto',
              path: 'inbox.dev@proton.me',
              queryParameters: {
                'subject': subject,
              });
          await launchUrl(url);
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Theme.of(context).colorScheme.onSecondary,
        child: SettingsOptionTile(
            leading: Icon(
              LucideIcons.bug,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            listViewSubtitle: ListViewSubtitle(
                text: 'Facing any issues?, describe it to us via mail'),
            listViewTitle: ListViewTitle(text: 'Report Bug')));
  }
}
