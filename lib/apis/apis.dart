// import 'dart:convert';
// import 'dart:developer';

// import 'package:csv/csv.dart';
// import 'package:http/http.dart';
// import 'package:vpn_basic_project/STARTER/helpers/pref.dart';
// import 'package:vpn_basic_project/core/models/vpn.dart';



// class APIs {
//   static Future<List<Vpn>> getVPNServers() //use this to get the servers list
//   async {
//     final List<Vpn> vpnList = [];
//     log('Getting servers');

//     try {
//       final listFromStorage = await Pref.getVpnList;
//       if (listFromStorage.isNotEmpty) {
//         log('Got list from storage');
//         log('total enteries ${listFromStorage.length}');
//         log('first entry is ${listFromStorage.first.countryLong}');
//         return listFromStorage;
//       }
//       log('no servers saved, going to API');
//       final res = await get(Uri.parse('ENV'))
//           .timeout(Duration(seconds: 400));
//       log('got response from API');
//       log('${res.body.toString()}');
//       final csvString = res.body.split("#")[1].replaceAll('*', '');

//       List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

//       final header = list[0];

//       for (int i = 1; i < list.length - 1; ++i) {
//         Map<String, dynamic> tempJson = {};

//         for (int j = 0; j < header.length; ++j) {
//           tempJson.addAll({header[j].toString(): list[i][j]});
//         }
//         vpnList.add(Vpn.fromJson(tempJson));
//       }
//     } catch (e) {
//       // MyDialogs.error(msg: e.toString());
//       log('\ngetVPNServersE: $e');
//     }
//     vpnList.shuffle();
//     log('Sorted all vpns total length now ${vpnList.length}');

//     if (vpnList.isNotEmpty) Pref.setVpnList = vpnList;
//     log('vpn list is set up in storage');

//     return vpnList;
//   }

  // static Future<void> getIPDetails({required Rx<IPDetails> ipData}) async {
  //   try {
  //     final res = await get(Uri.parse('ENV'));
  //     final data = jsonDecode(res.body);
  //     log(data.toString());
  //     ipData.value = IPDetails.fromJson(data);
  //   } catch (e) {
  //     // MyDialogs.error(msg: e.toString());
  //     log('\ngetIPDetailsE: $e');
  //   }
  // }
// }

// // Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36

// // For Understanding Purpose

// //*** CSV Data ***
// // Name,    Country,  Ping
// // Test1,   JP,       12
// // Test2,   US,       112
// // Test3,   IN,       7

// //*** List Data ***
// // [ [Name, Country, Ping], [Test1, JP, 12], [Test2, US, 112], [Test3, IN, 7] ]

// //*** Json Data ***
// // {"Name": "Test1", "Country": "JP", "Ping": 12}

