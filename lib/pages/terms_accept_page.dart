import 'package:azaadi_vpn_android/controller/hive_controller.dart';

import 'package:azaadi_vpn_android/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class TermsAcceptPage extends StatelessWidget {
  TermsAcceptPage({super.key});
  final Rx<bool> isTermsAccepted = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome to Azaadi Vpn',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
                child: Text(
                  'Please read',
                  style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Text(
                  softWrap: true,
                  'Before you start using Azaadi Vpn, we want to ensure you are fully informed about how we handle your data and the permissions we require.\n\nTo provide the best experience, Azaadi Vpn needs to collect some data. This includes but may not limited to:\n\n1. Device ID\n2. IP address (including country, time zone, ISP and other relavent info)\n3. Name and email address (if provided)\n\nTo read more about why we collect this data and how we use it, please read our full privacy policy below',
                  style: TextStyle(fontSize: 18, overflow: TextOverflow.clip),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.015),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        'https://github.com/temp-ali/azaadi-vpn/blob/main/Azaadi%20Vpn%20Privacy%20Policy'));
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Text(
                  softWrap: true,
                  'By checking the box below and proceeding further, you acknowledge that you have read and understood our Privacy Policy and consent to our collection of your data to provide our services\n',
                  style: TextStyle(fontSize: 18, overflow: TextOverflow.clip),
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
                        'I have read and accept the privacy policy',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold),
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
                                  () => SplashPage());
                            }
                          : null,
                      child: Text('Proceed')),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      )),
    );
  }
}
