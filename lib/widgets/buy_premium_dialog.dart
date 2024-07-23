import 'dart:ui';

import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BuyPremiumDialog extends StatelessWidget {
  const BuyPremiumDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
                constraints: BoxConstraints(minHeight: size.height * 0.25),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.2)
                ])),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.03,
                      horizontal: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Upgrade to Premium',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25))),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text('This feature requires premium version of App',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 15))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Later',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle()))),
                          ElevatedButton.icon(
                              onPressed: () {
                                Get.back();
                                Get.closeAllSnackbars();
                                Get.snackbar(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.02,
                                        horizontal: size.width * 0.01),
                                    icon: Icon(
                                      LucideIcons.crown,
                                      color: AppColors.premiumText,
                                    ),
                                    'Coming soon',
                                    'Feature under development');
                              },
                              icon: Icon(
                                LucideIcons.crown,
                                color: Colors.orange,
                              ),
                              label: Text('Go Premium',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 252, 178, 67),
                                    fontWeight: FontWeight.bold,
                                  )))),
                        ],
                      )
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
