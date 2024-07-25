import 'dart:developer';

import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/pages/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  static Rx<bool> isNativeAdLoaded = false.obs;
  static Rx<bool> showAds = HiveController.getAdsStatus.obs;
  static Rx<bool> isBannerAdLoaded = false.obs;
  static Rx<bool> isUnderTesting = HiveController.getIsUnderTesting.obs;
  NativeAd? ad;
  static Future<void> initAdService() async {
    await MobileAds.instance.initialize();
  }

  static String get bannerAdId {
    if (!kReleaseMode || isUnderTesting.value) {
      //test banner ad
      return 'ca-app-pub-3940256099942544/9214589741';
    }

    return '';
  }

  static String get iterstitialAdId {
    if (!kReleaseMode || isUnderTesting.value) {
      //test ad
      return 'ca-app-pub-3940256099942544/1033173712';
    }

    return '';
  }

  static String get nativeTestAdId {
    if (!kReleaseMode || isUnderTesting.value) {
      //test banner
      return 'ca-app-pub-3940256099942544/2247696110';
    }

    return '';
  }

  static String get rewardedTestAdId {
    if (!kReleaseMode || isUnderTesting.value) {
      //test id
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return '';
  }

//?//?//?//?//?//!//!//!//!//!//!
//!ALWAYS SHOW DIALOG PROMT BEFORE SHOWING A FULL SCREEN AD TO USER
  static final BannerAdListener listener = BannerAdListener(
    onAdLoaded: (ad) => log('ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      log('failed to load ad due to $error');
    },
    onAdOpened: (ad) => log('Ad opened'),
    onAdClosed: (ad) => log('Ad closed'),
  );
  static BannerAd? showBannerAd() {
    if (showAds.value) {
      return BannerAd(
          size: AdSize.banner,
          adUnitId: AdController.bannerAdId,
          listener: BannerAdListener(
            onAdLoaded: (ad) {
              isBannerAdLoaded.value = true;
            },
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
              log('failed to load ad due to $error');
            },
            onAdOpened: (ad) => log('Ad opened'),
            onAdClosed: (ad) => log('Ad closed'),
          ),
          request: AdRequest())
        ..load();
    }
    return null;
  }

  static void loadInterstitialAd({required Function onComplete}) {
    if (showAds.value) {
      InterstitialAd.load(
        adUnitId: AdController.iterstitialAdId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                onComplete();
              },
            );
            ad.show();
          },
          onAdFailedToLoad: (err) {
            log('Failed to load an interstitial ad: ${err.message}');
          },
        ),
      );
    }
  }

  static NativeAd? loadNativeAd() {
    if (showAds.value) {
      return NativeAd(
          adUnitId: AdController.nativeTestAdId,
          listener: NativeAdListener(
            onAdLoaded: (ad) {
              log('$NativeAd loaded.');
              isNativeAdLoaded.value = true;
            },
            onAdFailedToLoad: (ad, error) {
              // Dispose the ad here to free resources.
              debugPrint('$NativeAd failed to load: $error');
              ad.dispose();
            },
          ),
          request: const AdRequest(),
          // Styling
          nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.small,
          ))
        ..load();
    }
    return null;
  }

  static void showRewardedAd({required Function onComplete}) {
    RewardedAd.load(
      adUnitId: AdController.rewardedTestAdId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );
          ad.show(onUserEarnedReward: (ad, reward) {
            onComplete();
          });
        },
        onAdFailedToLoad: (err) {
          log('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
}
