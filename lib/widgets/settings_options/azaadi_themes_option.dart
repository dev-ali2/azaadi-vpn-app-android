import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AzaadiThemesOption extends StatelessWidget {
  const AzaadiThemesOption({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final hapticController = Get.find<HapticController>();
    return InkWell(
      onTap: () {
        hapticController.provideFeedback(FeedbackType.light);
        Future.delayed(Duration(milliseconds: 300)).then((value) => null);
      },
      borderRadius: BorderRadius.circular(20),
      splashColor: Theme.of(context).colorScheme.onSecondary,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: size.height * 0.001, horizontal: 10),
        child: Container(
            height: size.height * 0.08,
            width: double.infinity,
            child: ListTile(
                leading: Icon(
                  LucideIcons.paintbrush,
                  color: AppColors.premiumText,
                  size: 20,
                ),
                subtitle: RichText(
                    text: TextSpan(
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                          fontSize: 13,
                        )),
                        children: [
                      TextSpan(text: 'Current : '),
                      TextSpan(
                          text: 'default',
                          style: GoogleFonts.ptSans(
                              textStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary))),
                    ])),
                title: GradientAnimationText(
                  duration: Duration(seconds: 2),
                  colors: [
                    Colors.orange,
                    Theme.of(context).colorScheme.primary
                  ],
                  text: Text(
                    'Azaadi Themes',
                    style: GoogleFonts.ptSans(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ))),
      ),
    );
  }
}
