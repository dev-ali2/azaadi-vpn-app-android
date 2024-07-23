import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/widgets/listView_subtitle.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RestorePurchaseOption extends StatelessWidget {
  const RestorePurchaseOption({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final hapticController = Get.find<HapticController>();
    return InkWell(
        onTap: () async {
          hapticController.provideFeedback(FeedbackType.light);
          Get.closeAllSnackbars();
          Get.snackbar(
              margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.01),
              icon: Icon(
                LucideIcons.timer,
                color: Theme.of(context).colorScheme.primary,
              ),
              'Coming soon',
              'Currently under development');
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Theme.of(context).colorScheme.onSecondary,
        child: SettingsOptionTile(
            leading: Icon(
              LucideIcons.shoppingBag,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            listViewSubtitle: ListViewSubtitle(text: 'Coming soon!'),
            listViewTitle: ListViewTitle(text: 'Restore purchase')));
  }
}
