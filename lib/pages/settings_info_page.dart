import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SettingsInfoPage extends StatelessWidget {
  const SettingsInfoPage(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final nativeAd = AdController.loadNativeAd();
    final colors = Get.find<ColorController>();

    Size size = MediaQuery.of(context).size;
    return Obx(
      () => PopScope(
        onPopInvoked: (value) {
          if (nativeAd != null) nativeAd.dispose();
          AdController.isNativeAdLoaded.value = false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              title,
              style: GoogleFonts.ptSans(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(gradient: colors.pageGradient()),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                            horizontal: size.width * 0.03),
                        child: Text(
                          description.replaceAll('//', '\n\n'),
                          style: GoogleFonts.ptSans(
                              textStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: AdController.isNativeAdLoaded.value &&
                  AdController.showAds.value &&
                  nativeAd != null
              ? SizedBox(
                  height: 90,
                  child: AdWidget(ad: nativeAd),
                )
              : null,
        ),
      ),
    );
  }
}
