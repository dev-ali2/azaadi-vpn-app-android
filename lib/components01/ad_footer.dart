import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

class AdFooter extends StatefulWidget {
  const AdFooter({super.key});

  @override
  State<AdFooter> createState() => _AdFooterState();
}

class _AdFooterState extends State<AdFooter> {
  bool isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    createAd();
  }

  void createAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdController.bannerAdId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isAdLoaded = true;
            bannerAd = ad as BannerAd;
            if (bannerAd != null) setState(() {});
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            // log('failed to load ad due to $error');
          },
          // onAdOpened: (ad) => log('Ad opened'),
          // onAdClosed: (ad) => log('Ad closed'),
        ),
        request: AdRequest())
      ..load();
  }

  BannerAd? bannerAd;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: !isAdLoaded
          ? Shimmer(
              period: Duration(seconds: 2),
              direction: ShimmerDirection.ltr,
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                Theme.of(context).colorScheme.primary.withOpacity(1),
                Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                Theme.of(context).colorScheme.primary.withOpacity(1)
              ]),
              child: Container(
                height: size.height * 0.08,
                width: double.infinity,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    color: Colors.white.withOpacity(0.1)),
                child: Center(
                  child: Text('Loading Advertisement'),
                ),
              ),
            )
          : Container(
              height: size.height * 0.08,
              child: AdWidget(ad: bannerAd!),
            ),
    );
  }
}
