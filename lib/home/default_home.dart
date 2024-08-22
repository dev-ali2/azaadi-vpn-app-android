import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:flutter/material.dart';
import 'package:azaadi_vpn_android/components01/custom_appbar.dart';
import 'package:azaadi_vpn_android/components01/ad_footer.dart';
import 'package:azaadi_vpn_android/components01/app_footer_container.dart';
import 'package:azaadi_vpn_android/components01/app_title.dart';
import 'package:azaadi_vpn_android/components01/connect_button_container.dart';

class DefaultHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white.withOpacity(0.0001),
          Colors.black.withOpacity(0.2),
        ], begin: Alignment.topRight)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppbar(),
              AppTitle(),
              ConnectButtonContainer(),
              AppFooterContainer(),
              if (AdController.showAds.value ||
                  !PremiumController().isPremium.value)
                AdFooter(),
            ]),
      ),
    );
  }
}
