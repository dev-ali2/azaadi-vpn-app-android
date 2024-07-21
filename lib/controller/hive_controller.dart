import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';

class HiveController extends GetxController {
  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
    log('local storage enabled!');

    try {
      final List savedList = await jsonDecode(_box.get('vpnList2'));
      log('total saved vpns are ${savedList.length}');
    } catch (e) {
      log('no last connected vpn');
    }
  }

  //for storing single selected vpn details
  static Vpn get lastConnected =>
      Vpn.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
  static set saveThisVpn(Vpn v) => _box.put('vpn', jsonEncode(v));

  //getting vpn list
  static List<Vpn> get getVpnList {
    List<Vpn> temp = [];
    final data = jsonDecode(_box.get('vpnList2') ?? '[]');

    for (var i in data) temp.add(Vpn.fromJson(i));

    return temp;
  }

//store vpn data list
  static set setVpnList(List<Vpn> v) {
    _box.put('vpnList2', jsonEncode(v));
    log('New list is added with ${v.length} enteries');
  }

  //get sorted vpn list
  static List<Vpn> getSortedList() {
    List<Vpn> temp = HiveController.getVpnList;

    temp.sort((a, b) {
      double score1 = a.speed / a.numVpnSessions;
      double score2 = b.speed / b.numVpnSessions;
      return score2.compareTo(score1);
    });
    temp.removeWhere((map) => map.numVpnSessions < 0);

    return temp;
  }

  //delete all saved data
  static void deleteSavedServers() {
    _box.clear();
    log('Deleted previous vpns');
  }

  //haptics getter and setter
  static bool get getHapticStatus => _box.get('haptic') ?? true;

  static set setHapticValue(bool b) {
    _box.put('haptic', b);
  }

  //premium getter and setter
  static bool get getIsPremium => _box.get('isPremium') ?? false;
  static set setIsPremium(bool b) {
    _box.put('isPremium', b);
    log('Is Premium ${_box.get('isPremium')}');
  }

  //getter and setter for app version
  static set setAppVersion(String s) {
    _box.put('appVersion', s);
    log('Got app version $s');
  }

  static String get getAppVersion => _box.get('appVersion');

  //getter and setter for notices
  static set setNotice(String s) {
    _box.put('notice', s);
    log('Got release notes $s');
  }

  static String get getNotice => _box.get('notice') ?? '';

  //getter setter for initial notice
  static set setInitialNotice(String s) {
    _box.put('initNotice', s);
    log('Got initial notice $s');
  }

  static String get getInitialNotice => _box.get('initNotice') ?? '';

  //notification getter and setter
  static bool get getShowNotification => _box.get('showNotification') ?? false;
  static set setShowNotification(bool b) {
    _box.put('showNotification', b);
    log('show notification ${_box.get('showNotification')}');
  }
}