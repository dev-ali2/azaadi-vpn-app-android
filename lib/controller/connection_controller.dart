import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:math' as math;
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/widgets/permission_promt_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azaadi_vpn_android/apis/apis.dart';
import 'package:azaadi_vpn_android/controller/fetch_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/statistics_controller.dart';
import 'package:azaadi_vpn_android/core/models/services/vpn_engine.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:azaadi_vpn_android/core/models/vpn_config.dart';
// Import package
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConnectionController extends GetxController {
//variables
  final vpnState = 'Disconnected'.obs;
  Rx<bool> showAnimation = false.obs;
  Rx<Vpn> vpn = Vpn.fromJson({}).obs;
  Rx<bool> isConnectionStarted = false.obs;

  RxList randInt = [].obs;
  final hapticController = HapticController();
  Rx<bool> isValidatingServers = false.obs;
  //logic
  void listenVpnState() {
    VpnEngine.vpnStageSnapshot().listen((event) {
      // vpnState.value = event;
      if (HiveController.getShowNotification) {
        NotificationController.showNotification(
            'Connection Status', vpnState.value);
      }
      vpnState.value = setStatusMessage(event);
      if (vpnState == 'Disconnected') {
        StatsController.setTimerStatus = false;
        showAnimation.value = false;
        StatsController.setEncryptionStatus = false;
        AwesomeNotifications().cancelAll();
      }
      if (vpnState == 'Connected') {
        hapticController.provideFeedback(FeedbackType.heavy);
        HiveController.saveThisVpn = vpn.value;

        if (HiveController.getShowNotification) {
          NotificationController.showNotification(
              'Connection Status', vpnState.value);
        }
        log('saved connected vpn');
        StatsController.setTimerStatus = true;
        showAnimation.value = true;
        StatsController.setEncryptionStatus = true;
        randInt.clear();
        isConnectionStarted.value = false;
      }
    });
  }

  Future<void> connectVpn() async {
    log('Tapped');
    hapticController.provideFeedback(FeedbackType.medium);
    bool isUnderTesting = await HiveController.getIsUnderTesting;
    bool isInitial = HiveController.getIsInitialConnection;

    if (isUnderTesting) {
      Get.closeAllSnackbars();
      Get.snackbar(
          duration: Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          icon: Icon(
            LucideIcons.testTubeDiagonal,
            color: Colors.green,
          ),
          'Tester mode',
          'Conecting to servers is not available for testers right now');
      return;
    }
    if (isInitial) {
      HiveController.setIsInitialConnection = false;
      Get.to(
          transition: Transition.fadeIn,
          () => PermissionsPromtDialog(
              description:
                  'This will allow the app to create a secure vpn tunnel to encrypt the outgoing or incoming traffic\nNext time when you will click this button, the system will promt you to give this permission\nYou can easily allow or deny it from that system dialog',
              type: 'Vpn tunnel creation'));
      return;
    }

    Future.delayed(Duration(milliseconds: 0)).then((value) async {
      if (vpnState.value != 'Disconnected') {
        VpnEngine.stopVpn();
        vpnState.value = 'Disconnected';
        return;
      }
      try {
        final Vpn lastConnectedVpn = HiveController.lastConnected;
        if (lastConnectedVpn.openVPNConfigDataBase64 != '') {
          vpn.value = lastConnectedVpn;
          log('found saved vpn');
          // foundSavedVpn.value = true;
          manualConnection(vpn.value);
        } else {
          vpnState.value = 'Finding servers';
          // final List<Vpn> vpns = await FetchController.getVPNServers();
          final vpns = await HiveController.getVpnList;
          if (vpns.length <= 1) {
            vpnState.value = 'No available servers, exiting...';
            await Future.delayed(Duration(seconds: 2)).then((value) {
              VpnEngine.stopVpn();
              vpnState.value = 'Disconnected';
              return;
            });
          }
          log('no previous vpn was found');
          manualConnection(vpns[1]);
          // log('Connecting to vpn hostname : ${vpn.value.hostname}');
          // foundSavedVpn.value = false;
        }

        // log('from home controller got vpn list with length ${vpns.length}');
        // vpn.value = vpns[10];

        ///Stop right here if user not select a vpn
        // if (vpn.value.openVPNConfigDataBase64.isEmpty) {
        //   log('from home controller vpnconfig empty so returning');
        // }
        // log('not returned here');

        // if (vpnState.value == 'Disconnected') {
        //   //converting given encrypted openvpn data from encoded to utf format
        //   log('Time to start engine');
        //   VpnConfig vpnData = decodeData();

        //   ///Start if stage is disconnected
        //   VpnEngine.startVpn(vpnData);
        // } else {
        //   ///Stop if stage is "not" disconnected
        //   VpnEngine.stopVpn();
        // }
      } catch (e) {
        log('error from home controller ${e.toString()}');
      }
    });
  }

  Color buttonColor(BuildContext context) {
    switch (vpnState.value) {
      case 'Disconnected':
        return Theme.of(context).colorScheme.onSecondary;
      case 'Finding servers':
        return Colors.indigoAccent;
      case 'Almost done':
        return Colors.yellow;
      case 'Connecting':
        return Color.fromARGB(255, 252, 110, 67);
      case 'Checking availability':
        return Colors.blueGrey;
      case 'Connected':
        return Colors.green;
      case 'Confirming location':
        return Colors.deepPurple;
      case 'Trying to reconnect':
        return const Color.fromARGB(255, 255, 101, 101);
      case 'No available servers, exiting...':
        return Colors.teal;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  void manualConnection(Vpn v) {
    bool isInitial = HiveController.getIsInitialConnection;
    if (isInitial) {
      HiveController.setIsInitialConnection = false;
      Get.to(
          transition: Transition.fadeIn,
          () => PermissionsPromtDialog(
              description:
                  'This will allow the app to create a secure vpn tunnel to encrypt the outgoing or incoming traffic\nNext time when you will click this button, the system will promt you to give this permission\nYou can easily allow or deny it from that system dialog',
              type: 'Vpn tunnel creation'));
      return;
    }
    try {
      vpn.value = v;
      if (vpnState.value != 'Disconnected') {
        VpnEngine.stopVpn();
      }
      Future.delayed(Duration(milliseconds: 200))
          .then((value) => Get.back())
          .then((value) => Future.delayed(Duration(milliseconds: 200))
              .then((value) => Get.back()));
      final VpnConfig vpnData = decodeData();

      Future.delayed(Duration(milliseconds: 1000))
          .then((value) => vpnState.value = 'Confirming location');

      Future.delayed(Duration(milliseconds: 3000)).then((value) {
        VpnEngine.startVpn(vpnData);
        validateConnection();
      });
    } catch (e) {
      // log('error in manuual connection function : ${e.toString()}');
    }
  }

//decoding process
  VpnConfig decodeData() {
    //converting given encrypted openvpn data from encoded to utf format
    final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
    final config = Utf8Decoder().convert(data);
    final vpnConfig = VpnConfig(
        country: vpn.value.countryLong,
        username: 'vpn',
        password: 'vpn',
        config: config);
    return vpnConfig;
  }

  //custom status messages
  String setStatusMessage(String s) {
    switch (s) {
      case VpnEngine.vpnAuthenticating:
        return 'Almost done';
      case VpnEngine.vpnConnected:
        return 'Connected';
      case VpnEngine.vpnConnecting:
        return 'Connecting';
      case VpnEngine.vpnDenied:
        return 'Connection denied';
      case VpnEngine.vpnDisconnected:
        return 'Disconnected';
      case VpnEngine.vpnNoConnection:
        return 'No Connections';
      case VpnEngine.vpnPrepare:
        return 'Starting Vpn';
      case VpnEngine.vpnReconnect:
        return 'Trying to reconnect';
      case VpnEngine.vpnWaitConnection:
        return 'Checking availability';
      default:
        return 'Disconnected';
    }
  }

  //validate connection
  void validateConnection() {
    // log('running validate');
    isConnectionStarted.value = true;
    Future.delayed(Duration(seconds: 12)).then((value) async {
      if (vpnState.value != 'Connected' && vpnState.value != 'Disconnected') {
        VpnEngine.stopVpn();
        vpnState.value = 'Retrying...';
        final List<Vpn> servers = await HiveController.getVpnList;
        // log('from validate got saved vpn list with ${servers.length} enteries');

        // final List<Vpn> servers = [];
        // final tempList =
        //     await Supabase.instance.client.from('vpns_table').select();
        // log('in validation got vpn list ${tempList.length}');
        // for (int i = 0; i < tempList.length; i++) {
        //   servers.add(Vpn.fromJson(tempList[i]));
        // }
        int randomNumber = generateRandomInt(servers.length);
        // log('random number is ${randomNumber}');
        final Vpn selectedServer = servers[randomNumber];
        vpn.value = selectedServer;

        reconnectVpn(vpn.value);
      } else {
        isConnectionStarted.value = false;
        randInt.clear();
      }
    });
  }

  // check random number
  int generateRandomInt(int listLength) {
    int value = math.Random().nextInt(listLength);
    bool isAlready = randInt.contains(value);

    while (isAlready) {
      int temp = math.Random().nextInt(listLength);
      isAlready = randInt.contains(temp);
      if (!isAlready) {
        value = temp;
      }
    }

    randInt.add(value);
    return value;
  }

  //re connect vpn
  void reconnectVpn(Vpn v) {
    if (vpnState.value != 'Disconnected') {
      VpnEngine.stopVpn();
    }
    final VpnConfig data = decodeData();
    VpnEngine.startVpn(data);
    validateConnection();
  }

  //validate servers
  Future<void> validateServers() async {
    try {
      isValidatingServers.value = true;
      final downloadedServers =
          await Supabase.instance.client.from('vpns_table').select();
      List<Vpn> finalList = [];
      for (int i = 0; i < downloadedServers.length; i++) {
        finalList.add(Vpn.fromJson(downloadedServers[i]));
      }
      finalList.shuffle();
      HiveController.setVpnList = finalList;
      isValidatingServers.value = false;
    } catch (e) {
      //TODO:
    }
  }
}
