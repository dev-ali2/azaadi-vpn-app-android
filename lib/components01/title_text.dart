import 'dart:ui';

import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/pages/settings_page.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:azaadi_vpn_android/widgets/permission_promt_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumController = Get.find<PremiumController>();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.closeAllSnackbars();
        Get.snackbar(
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.01),
            icon: Icon(
              LucideIcons.crown,
              color: AppColors.premiumText,
            ),
            'Coming soon',
            'Feature under development');
      },
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.04, left: size.width * 0.03),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Center(
                child: Obx(
                  () => Text(
                      premiumController.isPremium.value
                          ? 'Premium 🤩'
                          : '👑  Go premium',
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(color: Colors.orange, fontSize: 16))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
