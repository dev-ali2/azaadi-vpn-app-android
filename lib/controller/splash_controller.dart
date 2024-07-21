import 'dart:developer';

import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:azaadi_vpn_android/pages/azaadi_initial_notice_page.dart';
import 'package:azaadi_vpn_android/pages/azaadi_notice_page.dart';

import 'package:get/get.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController {
  final supabase = Supabase.instance.client;
  Rx<String> messsage = ''.obs;
  Rx<bool> showLoading = true.obs;
  bool serversAccess = true;
  Rx<bool> enableRetryButton = true.obs;

  Future<void> splashLogic() async {
    messsage.value = 'Initializing';
    showLoading.value = true;

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
              () => AzaadiInitialNoticePage(
                    description: newNotice,
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
              () => AzaadiNoticePage(
                    description: newNotice,
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
