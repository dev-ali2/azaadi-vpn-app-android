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
    // log('local storage enabled!');

    try {
      final List savedList = await jsonDecode(_box.get('vpnList2'));
      // log('total saved vpns are ${savedList.length}');
    } catch (e) {
      // log('no last connected vpn');
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
    // log('New list is added with ${v.length} enteries');
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
    // log('Deleted previous vpns');
  }

  //haptics getter and setter
  static bool get getHapticStatus => _box.get('haptic') ?? true;

  static set setHapticValue(bool b) {
    _box.put('haptic', b);
  }

  //premium getter and setter
  static bool get getIsPremium =>
      _box.get('isPremium') ?? true; //TODO set this to false later
  static set setIsPremium(bool b) {
    _box.put('isPremium', b);
    // log('Is Premium ${_box.get('isPremium')}');
  }

  //getter and setter for app version
  static set setAppVersion(String s) {
    _box.put('appVersion', s);
    // log('Got app version $s');
  }

  static String get getAppVersion => _box.get('appVersion');

  //getter and setter for notices
  static set setNotice(String s) {
    _box.put('notice', s);
    // log('Got release notes $s');
  }

  static String get getNotice => _box.get('notice') ?? '';

  //getter setter for accepting terms
  static set setTermsStatus(bool b) {
    _box.put('termsStatus', b);
    // log('Terms set to  $b');
  }

  static bool get getTermsStatus => _box.get('termsStatus') ?? false;

  //notification getter and setter
  static bool get getShowNotification => _box.get('showNotification') ?? false;
  static set setShowNotification(bool b) {
    _box.put('showNotification', b);
    // log('show notification ${_box.get('showNotification')}');
  }

  // getter and setter for privacy policy
  static String get getPrivacyPolicy => _box.get('privacyPolicy') ?? '';
  static set setPrivacyPolicy(String s) {
    _box.put('privacyPolicy', s);
  }

  // getter and setter for terms of use
  static String get getTermsOfUse => _box.get('termsOfUse') ?? '';
  static set setTermOfUse(String s) {
    _box.put('termsOfUse', s);
  }

  // getter and setter for faqs
  static String get getFaqs => _box.get('faqs') ?? '';
  static set setFaqs(String s) {
    _box.put('faqs', s);
  }

  // getter and setter for  app version info
  static Map<String, dynamic> get getDeviceInfo =>
      jsonDecode(_box.get('deviceInfo')) ?? '{}';
  static set setDeviceInfo(Map<String, dynamic> data) {
    _box.put('deviceInfo', jsonEncode(data));
    // log('saved device data ${data.toString()}');
  }

  //initial notification getter and setter
  static bool get getIsInitialNotification =>
      _box.get('isInitialNotification') ?? true;
  static set setIsInitialNotification(bool b) {
    _box.put('isInitialNotification', b);
  }

  //initial connection getter and setter
  static bool get getIsInitialConnection =>
      _box.get('isInitialConnection') ?? true;
  static set setIsInitialConnection(bool b) {
    _box.put('isInitialConnection', b);
  }

  //show ads getter and setter
  static bool get getAdsStatus => _box.get('AdsStatus') ?? true;
  static set setAdsStatus(bool b) {
    _box.put('AdsStatus', b);
    // log('Ads show set to ${b}');
  }

  // user block getter and setter
  static bool get getIsUserBlocked => _box.get('userStatus') ?? false;
  static set setIsUserBlocked(bool b) {
    _box.put('userStatus', b);
  }

  // user block getter and setter
  static bool get getShowAzaadiThemes =>
      _box.get('azaadiThemesStatus') ?? false;
  static set setAzaadiThemesStatus(bool b) {
    _box.put('azaadiThemesStatus', b);
  }

  // Testing app getter and setter
  static bool get getIsUnderTesting => _box.get('testingStatus') ?? false;
  static set setIsUnderTesting(bool b) {
    _box.put('testingStatus', b);
  }
}
