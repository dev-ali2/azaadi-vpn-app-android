import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/splash_controller.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:azaadi_vpn_android/pages/settings_info_page.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAcceptDialog extends StatelessWidget {
  TermsAcceptDialog({super.key});
  final Rx<bool> isTermsAccepted = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(0.2),
      body: Center(
          child: Container(
        // height: size.height * 0.5,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
              Theme.of(context).colorScheme.secondary.withOpacity(0.3)
            ])),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
              child: Text(
                'Welcome',
                style: GoogleFonts.ptSans(
                    textStyle: TextStyle(
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                children: [
                  Text(
                    softWrap: true,
                    'Please read and accept our Privacy Policy and Terms of use in order to use Azaadi Vpn',
                    style: GoogleFonts.ptSans(
                        textStyle: TextStyle(
                            fontSize: 18, overflow: TextOverflow.clip)),
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: size.height * 0.015),
              child: TextButton(
                onPressed: () {
                  String policy = HiveController.getPrivacyPolicy;

                  Get.to(
                      transition: Transition.cupertino,
                      () => SettingsInfoPage(
                          title: 'Privacy Policy', description: policy));
                },
                child: Text('Privacy policy',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: size.height * 0.015),
              child: TextButton(
                onPressed: () {
                  String terms = HiveController.getTermsOfUse;

                  Get.to(
                      transition: Transition.cupertino,
                      () => SettingsInfoPage(
                          title: 'Terms of use', description: terms));
                },
                child: Text('Terms of use',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: isTermsAccepted.value,
                        onChanged: (value) {
                          isTermsAccepted.value = !isTermsAccepted.value;
                        }),
                  ),
                  SizedBox(
                    width: size.width * 0.65,
                    child: Text(
                      softWrap: true,
                      'I accept the privacy policy and terms of use!',
                      style: GoogleFonts.ptSans(
                          textStyle: TextStyle(
                              fontSize: 15, overflow: TextOverflow.clip)),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.025),
                child: OutlinedButton(
                    onPressed: isTermsAccepted.value
                        ? () async {
                            HiveController.setTermsStatus = true;
                            Get.offAll(
                                transition: Transition.fade,
                                duration: Duration(milliseconds: 1000),
                                () => DefaultHomeScreen());
                          }
                        : null,
                    child: Text('Proceed')),
              ),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      )),
    );
  }
}
