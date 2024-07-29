import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/widgets/buy_premium_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:azaadi_vpn_android/controller/statistics_controller.dart';
import 'package:azaadi_vpn_android/helpers/timer_widget.dart';
import 'package:azaadi_vpn_android/widgets/more_info_dialog.dart';

class AppFooterContainer2 extends StatelessWidget {
  AppFooterContainer2({super.key});
  final statsController = StatsController();

  @override
  Widget build(BuildContext context) {
    final colors = Get.find<ColorController>();
    final premiumController = Get.find<PremiumController>();
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          top: size.height * 0.00,
          right: size.width * 0.05,
          left: size.width * 0.05,
          bottom: size.height * 0.01),
      height: size.height * 0.24,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //first row
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.15, vertical: size.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Connection time',
                  ),

                  Obx(() => CountDownTimer(
                      startTimer: StatsController.timerStatus)) //? custom timer
                ],
              ),
            ),
            Divider(
              endIndent: size.width * 0.2,
              indent: size.width * 0.2,
              color: colors.dividerColor(context),
            ),
            //second row
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.15, vertical: size.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Traffic encryption',
                  ),
                  Obx(
                    () => Text(
                      StatsController.encryptionStatus
                          ? 'Enabled'
                          : 'Unavailable',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              endIndent: size.width * 0.2,
              indent: size.width * 0.2,
              color: colors.dividerColor(context),
            ),
            Center(
              child: Obx(
                () => TextButton.icon(
                  label: Text('Detailed info'),
                  icon: Icon(
                    LucideIcons.crown,
                    color: premiumController.isPremium.value
                        ? Theme.of(context).colorScheme.primary
                        : Colors.orange,
                  ),
                  onPressed: () {
                    HapticController().provideFeedback(FeedbackType.selection);
                    if (!premiumController.isPremium.value) {
                      showDialog(
                        context: context,
                        builder: (context) => BuyPremiumDialog(),
                      );
                      return;
                    }
                    Get.closeAllSnackbars();

                    showDialog(
                      context: context,
                      builder: (context) => MoreInfoDialog(), //TODO un-comment
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
