import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/pages/locations_page.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:azaadi_vpn_android/widgets/buy_premium_dialog.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChangeLocationOption extends StatelessWidget {
  const ChangeLocationOption({super.key});

  @override
  Widget build(BuildContext context) {
    final hapticController = Get.find<HapticController>();
    final premiumController = Get.find<PremiumController>();

    return InkWell(
        onTap: () {
          hapticController.provideFeedback(FeedbackType.light);
          bool isPro = HiveController.getIsPremium;
          if (isPro) {
            Future.delayed(Duration(milliseconds: 300)).then((value) => Get.to(
                transition: Transition.cupertino,
                duration: Duration(milliseconds: 400),
                () => LocationsPage()));
          } else {
            showDialog(
              context: context,
              builder: (context) => BuyPremiumDialog(),
            );
          }
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Theme.of(context).colorScheme.onSecondary,
        child: SettingsOptionTile(
            leading: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            listViewSubtitle: Obx(
              () => RichText(
                  text: TextSpan(
                      style: GoogleFonts.ptSans(
                          textStyle: TextStyle(
                        fontSize: 12,
                      )),
                      children: [
                    TextSpan(text: 'Current : '),
                    TextSpan(
                        text: premiumController.isPremium.value
                            ? HiveController.lastConnected.countryLong != ''
                                ? '${HiveController.lastConnected.countryLong}'
                                : 'None'
                            : 'auto',
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary))),
                  ])),
            ),
            trailing: Obx(
              () => Icon(
                LucideIcons.crown,
                color: premiumController.isPremium.value
                    ? Theme.of(context).colorScheme.primary
                    : AppColors.premiumText,
                size: 18,
              ),
            ),
            listViewTitle: ListViewTitle(text: 'Change Location')));
  }
}
