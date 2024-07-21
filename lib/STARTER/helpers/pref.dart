// import 'dart:convert';
// import 'dart:developer';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vpn_basic_project/core/models/vpn.dart';

// class Pref {
//   static late Box _box;

//   static Future<void> initializeHive() async {
//     await Hive.initFlutter();
//     _box = await Hive.openBox('data');
//     log('local storage enabled!');
//   }

//   // //for storing theme data
//   // static bool get isDarkMode => _box.get('isDarkMode') ?? false;
//   // static set isDarkMode(bool v) => _box.put('isDarkMode', v);

//   //for storing single selected vpn details
//   static Vpn get vpn => Vpn.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
//   static set vpn(Vpn v) => _box.put('vpn', jsonEncode(v));

//   //for storing vpn servers details
//   static List<Vpn> get getVpnList {
//     List<Vpn> temp = [];
//     final data = jsonDecode(_box.get('vpnList') ?? '[]');

//     for (var i in data) temp.add(Vpn.fromJson(i));

//     return temp;
//   }

//   static set setVpnList(List<Vpn> v) => _box.put('vpnList', jsonEncode(v));
// }
