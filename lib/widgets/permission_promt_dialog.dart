import 'dart:ui';

import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionsPromtDialog extends StatelessWidget {
  const PermissionsPromtDialog(
      {super.key, required this.description, required this.type});
  final String type;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(0.3),
      body: Center(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.centerLeft, colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                ]),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.025),
                    child: Text(
                      'Permissions consent',
                      style: GoogleFonts.ptSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: Text(
                      'Type : $type',
                      style: GoogleFonts.ptSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.025),
                    child: SizedBox(
                      width: size.width * 0.64,
                      child: Text(
                        softWrap: true,
                        description,
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                                fontSize: 18, overflow: TextOverflow.clip)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.025),
                    child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Understood')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
