import 'dart:ui';

import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:azaadi_vpn_android/pages/settings_page.dart';

class SettingsIcon2 extends StatelessWidget {
  const SettingsIcon2({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 400),
            () => SettingsPage());
        HapticController().provideFeedback(FeedbackType.light);
      },
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.04, right: size.width * 0.03),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Center(
                  child: Icon(
                LucideIcons.settings2,
                size: 20,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
