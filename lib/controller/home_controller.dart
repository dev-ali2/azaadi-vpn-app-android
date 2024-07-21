// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vpn_basic_project/STARTER/helpers/pref.dart';
// import 'package:vpn_basic_project/core/models/vpn_config.dart';
// import 'package:vpn_basic_project/core/models/services/vpn_engine.dart';
// import 'package:vpn_basic_project/apis/apis.dart';
// import 'package:vpn_basic_project/core/models/vpn.dart';

// // import '../helpers/ad_helper.dart';
// // import '../helpers/my_dialogs.dart';
// // import '../helpers/pref.dart';
// // import '../models/vpn.dart';
// // import '../models/vpn_config.dart';
// // import '../services/vpn_engine.dart';

// class HomeController extends GetxController {
//   // final Rx<Vpn> vpn = Pref.vpn.obs;
//   Rx<Vpn> vpn = Vpn.fromJson({}).obs;

//   final vpnState = VpnEngine.vpnDisconnected.obs;
//   final RxBool startTimer = false.obs;

//   Future<void> connectVpn() async {
//     log('Tapped');
//     try {
//       final List<Vpn> vpns = await APIs.getVPNServers();
//       log('from home controller got vpn list with length ${vpns.length}');
//       vpn.value = vpns[10];

//       ///Stop right here if user not select a vpn
//       if (vpn.value.openVPNConfigDataBase64.isEmpty) {
//         log('from home controller vpnconfig empty so returning');
//       }
//       log('not returned here');

//       if (vpnState.value == VpnEngine.vpnDisconnected) {
//         //converting given encrypted openvpn data from encoded to utf format

//         final data =
//             Base64Decoder().convert(vpn!.value.openVPNConfigDataBase64);
//         final config = Utf8Decoder().convert(data);
//         final vpnConfig = VpnConfig(
//             country: vpn!.value.countryLong,
//             username: 'vpn',
//             password: 'vpn',
//             config: config);
//         log('Time to start engine');

//         ///Start if stage is disconnected
//         VpnEngine.startVpn(vpnConfig);
//       } else {
//         ///Stop if stage is "not" disconnected
//         VpnEngine.stopVpn();
//       }
//     } catch (e) {
//       log('error from home controller ${e.toString()}');
//     }
//   }

//   Color get bc {
//     switch (vpnState.value) {
//       case VpnEngine.vpnDisconnected:
//         return Colors.purple;
//       case VpnEngine.vpnConnected:
//         return Colors.green;
//       default:
//         return Colors.red;
//     }
//   }

// //? below is pre made code
//   // void connectToVpn() async {
//   //   // if (vpn.value.openVPNConfigDataBase64.isEmpty) {
//   //   // MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
//   //   //   return;
//   //   // }

//   //   if (vpnState.value == VpnEngine.vpnDisconnected) {
//   //     // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}');

//   //     // final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
//   //     // final config = Utf8Decoder().convert(data);
//   //     // final vpnConfig = VpnConfig(
//   //     //     country: vpn.value.countryLong,
//   //     //     username: 'vpn',
//   //     //     password: 'vpn',
//   //     //     config: config);

//   //     // log('\nAfter: $config');

//   //     //code to show interstitial ad and then connect to vpn
//   //     // AdHelper.showInterstitialAd(onComplete: () async {
//   //     //   await VpnEngine.startVpn(vpnConfig);
//   //     // });
//   //   } else {
//   //     await VpnEngine.stopVpn();
//   //   }

//   // vpn buttons color

//   // vpn button text
// }
