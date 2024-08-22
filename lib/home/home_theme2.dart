import 'package:azaadi_vpn_android/components03/app_footer_container.dart';
import 'package:azaadi_vpn_android/components03/app_title.dart';
import 'package:azaadi_vpn_android/components03/connect_button_container.dart';
import 'package:azaadi_vpn_android/components03/custom_appbar.dart';
import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:flutter/material.dart';
import 'package:azaadi_vpn_android/components01/ad_footer.dart';

class HomeTheme2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white.withAlpha(150),
            Colors.green.withAlpha(170),
          ], stops: [
            0.1,
            0.8
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppbar2(),
              AppTitle2(),
              ConnectButtonContainer2(),
              AppFooterContainer2(),
              if (AdController.showAds.value ||
                  !PremiumController().isPremium.value)
                AdFooter(),
            ]),
      ),
    );
  }
}
