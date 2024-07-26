import 'dart:convert';
import 'dart:developer';

import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/init_controllers.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:azaadi_vpn_android/pages/notice_page.dart';
import 'package:azaadi_vpn_android/widgets/terms_accept_dialog.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
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
    String deviceId =
        await PlatformDeviceId.getDeviceId ?? DateTime.now().toString();
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
//checking app status
        final List appStatus = await supabase.from('app_stats').select();
        final userRegistrationInfo = await supabase
            .from('user_registrations')
            .select()
            .eq('device_id', deviceId);
        final userStats = await supabase
            .from('users_stats')
            .select()
            .eq('device_id', deviceId);

        //checking and storing user registration info
        if (userRegistrationInfo.length == 0) {
          messsage.value = 'Setting up for first use';
          try {
            final fetchIpDetails =
                await get(Uri.parse('http://ip-api.com/json/'));
            final Map<String, dynamic> gotDetails =
                json.decode(fetchIpDetails.body);

            await supabase.from('user_registrations').insert({
              'ip_address': gotDetails['query'],
              'country': gotDetails['country'],
              'country_code':
                  gotDetails['countryCode'].toString().toLowerCase(),
              'region': gotDetails['regionName'],
              'city': gotDetails['city'],
              'zip_code': gotDetails['zip'],
              'time_zone': gotDetails['timezone'],
              'isp': gotDetails['isp'],
              'device_id': deviceId
            });
          } catch (e) {
            messsage.value = 'Error setting up app';
            showLoading.value = false;
            // log('error from user registration ${e.toString()}');
            return;
          }
        }
        // checking and storing user status info
        if (userStats.length == 0) {
          messsage.value = 'Setting up for first use';
          try {
            HiveController.setIsUnderTesting = appStatus.first['is_testing'];
            await supabase.from('users_stats').insert({
              'is_premium': true, //TODO set this false later
              'is_blocked': false,
              'app_version': info['appVersion'],
              'app_package': info['packageName'],
              'show_ads': true,
              'access_themes': true,
              'device_id': deviceId,
              'is_tester': appStatus.first['is_testing'] as bool,
            });
          } catch (e) {
            messsage.value = 'Error while setting up the app';
            showLoading.value = false;
            // log('error in user stats ${e.toString()}');
            return;
          }
        } else {
          HiveController.setIsUnderTesting = userStats.first['is_tester'];
          HiveController.setIsPremium = userStats.first['is_premium'] as bool;
          HiveController.setAdsStatus = userStats.first['show_ads'] as bool;
          HiveController.setAzaadiThemesStatus =
              userStats.first['access_themes'] as bool;
          HiveController.setIsUserBlocked =
              userStats.first['is_blocked'] as bool;
        }

        if (HiveController.getIsUserBlocked) {
          messsage.value =
              'You are blocked from using this app\nFor further details, mail at\ninbox.dev@proton.me\nDevice id: ${deviceId}';
          showLoading.value = false;
          return;
        }

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
          messsage.value = 'App under maintainance\n Please try again later';
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

        // initializing controllers
        InitControllers.initControllers();

        //? check app version update

        String appVersion =
            await HiveController.getDeviceInfo['appVersion'] as String;
        appVersion = appVersion.replaceAll('.', '');
        int finalSavedVersion = int.parse(appVersion);

        String onlineAppVersion = appStatus.first['app_version'] as String;
        onlineAppVersion = onlineAppVersion.replaceAll('.', '');
        int finalOnlineVersion = int.parse(onlineAppVersion);
        // log('saved int value $finalSavedVersion');
        // log('online int value $finalOnlineVersion');

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

        //? check terms status
        bool termsStatus = await HiveController.getTermsStatus;
        if (!termsStatus) {
          Get.offAll(transition: Transition.fade, () => TermsAcceptDialog());

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
        // log(e.toString());
        messsage.value = 'Something went wrong';
        showLoading.value = false;
      }
    });
  }
}
