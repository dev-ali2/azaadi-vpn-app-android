import 'dart:developer';

import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:azaadi_vpn_android/pages/notice_page.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:platform_device_id/platform_device_id.dart';

class SplashController extends GetxController {
  final supabase = Supabase.instance.client;
  Rx<String> messsage = ''.obs;
  Rx<bool> showLoading = true.obs;
  bool serversAccess = true;
  Rx<bool> enableRetryButton = true.obs;

  Future<void> splashLogic() async {
    messsage.value = 'Initializing';
    showLoading.value = true;
    final packageInfo = await PackageInfo.fromPlatform();

    // store current app version and device info
    String deviceId = await PlatformDeviceId.getDeviceId ?? '';
    final Map<String, dynamic> info = {
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'appVersion': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
      'deviceId': deviceId
    };
    HiveController.setDeviceInfo = info;

    //check connection
    Future.delayed(Duration(seconds: 1)).then((value) async {
      messsage.value = 'Checking network';
      try {
        bool isConnected = await SimpleConnectionChecker.isConnectedToInternet(
            lookUpAddress: 'www.facebook.com');
        if (!isConnected) {
          messsage.value = 'No internet connection';
          showLoading.value = false;
          return;
        }
        //connect to database
        messsage.value = 'Validating app status';
        final List appStatus = await supabase.from('app_stats').select();
        //? store privacy policy, terms of use and faqs
        String savedPrivacyPolicy = await HiveController.getPrivacyPolicy;
        String gotPrivacyPolicy = appStatus.first['privacy_policy'] as String;
        if (savedPrivacyPolicy != gotPrivacyPolicy) {
          HiveController.setPrivacyPolicy = gotPrivacyPolicy;
        }
        //
        String savedTermsOfUse = await HiveController.getTermsOfUse;
        String gotTermsOfUse = appStatus.first['terms_of_use'] as String;
        if (savedTermsOfUse != gotTermsOfUse) {
          HiveController.setTermOfUse = gotTermsOfUse;
        }
        //
        String savedFaqs = await HiveController.getFaqs;
        String gotFaqs = appStatus.first['faqs'] as String;
        if (savedFaqs != gotFaqs) {
          HiveController.setFaqs = gotFaqs;
        }
        if (appStatus.first['open_app'] == false) {
          messsage.value = 'App access denied';
          showLoading.value = false;
          return;
        }
        if (appStatus.first['see_servers'] == false) {
          messsage.value = 'Server access denied';
          showLoading.value = false;
          serversAccess = false;
          return;
        }
        //downloading and saving servers
        messsage.value = 'Checking locations';
        final downloadedServers = await supabase.from('vpns_table').select();
        List<Vpn> finalList = [];
        for (int i = 0; i < downloadedServers.length; i++) {
          finalList.add(Vpn.fromJson(downloadedServers[i]));
        }
        HiveController.setVpnList = finalList;

        //? check app version update

        String appVersion =
            await HiveController.getDeviceInfo['appVersion'] as String;
        appVersion = appVersion.replaceAll('.', '');
        int finalSavedVersion = int.parse(appVersion);

        String onlineAppVersion = appStatus.first['app_version'] as String;
        onlineAppVersion = onlineAppVersion.replaceAll('.', '');
        int finalOnlineVersion = int.parse(onlineAppVersion);
        log('saved int value $finalSavedVersion');
        log('online int value $finalOnlineVersion');

        if (finalOnlineVersion > finalSavedVersion) {
          Get.offAll(
              transition: Transition.fade,
              duration: Duration(milliseconds: 1000),
              () => NoticePage(
                    title: 'Update Available',
                    subtitle: 'A new version of app is available.',
                    description:
                        'Please Update to keep using the app\n\nGo to playstore to see available update',
                    showButton: false,
                  ));

          return;
        }

        //? check initial notice
        String initialSavedNotice = HiveController.getInitialNotice;
        if ((initialSavedNotice !=
                (appStatus.first['initial_notice'] as String)) &&
            (appStatus.first['initial_notice'] as String) != '') {
          String newNotice = (appStatus.first['initial_notice'] as String);
          HiveController.setInitialNotice = newNotice;
          Get.offAll(
              transition: Transition.fade,
              duration: Duration(milliseconds: 1000),
              () => NoticePage(
                    title: 'Welcome',
                    subtitle: 'Please read this',
                    description: newNotice,
                    showButton: true,
                  ));

          return;
        }

        //? check notes
        String notesFromStorage = HiveController.getNotice;
        if ((notesFromStorage != (appStatus.first['notice'] as String)) &&
            (appStatus.first['notice'] as String) != '') {
          String newNotice = (appStatus.first['notice'] as String);
          HiveController.setNotice = newNotice;
          Get.offAll(
              transition: Transition.fade,
              duration: Duration(milliseconds: 1000),
              () => NoticePage(
                    title: 'Azaadi Notice Board',
                    subtitle: 'New Notice',
                    description: newNotice,
                    showButton: true,
                  ));

          return;
        }

        messsage.value = 'Freedom Awaits You';
        showLoading.value = false;
        enableRetryButton.value = false;
        Future.delayed(Duration(seconds: 1)).then((value) {
          Get.offAll(
              transition: Transition.fade,
              duration: Duration(milliseconds: 1000),
              () => DefaultHomeScreen());
        });
      } catch (e) {
        log(e.toString());
        messsage.value = 'Something went wrong';
        showLoading.value = false;
      }
    });
  }
}
