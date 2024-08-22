import 'package:azaadi_vpn_android/components02/app_footer_container.dart';
import 'package:azaadi_vpn_android/components02/app_title.dart';
import 'package:azaadi_vpn_android/components02/connect_button_container.dart';
import 'package:azaadi_vpn_android/components02/custom_appbar.dart';
import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:flutter/material.dart';
import 'package:azaadi_vpn_android/components01/ad_footer.dart';

class HomeTheme1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.green.withAlpha(150),
            Colors.red.withAlpha(170),
          ], stops: [
            0.3,
            0.8
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppbar1(),
              AppTitle1(),
              ConnectButtonContainer1(),
              AppFooterContainer1(),
              if (AdController.showAds.value ||
                  !PremiumController().isPremium.value)
                AdFooter(),
            ]),
      ),
    );
  }
}
