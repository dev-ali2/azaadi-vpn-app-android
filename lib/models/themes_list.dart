import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:azaadi_vpn_android/home/home_theme1.dart';
import 'package:azaadi_vpn_android/home/home_theme2.dart';
import 'package:flutter/material.dart';

class ThemesList {
  static List<Map<String, dynamic>> themesInfo = [
    {
      'name': 'Default',
      'isDefault': true,
      'showType': false,
      'canBuy': false,
      'isPaid': false,
      'index': 0,
      'preview': 'assets/themes/defaulttheme.jpg',
      'gradient': LinearGradient(begin: Alignment.centerLeft, colors: [
        const Color.fromARGB(255, 1, 153, 6).withOpacity(0.2),
        Colors.green.withOpacity(0.2),
        Colors.white.withOpacity(0.2)
      ]),
    },
    {
      'name': 'Azaadi Theme 1',
      'isDefault': false,
      'showType': true,
      'isPaid': true,
      'canBuy': true,
      'index': 1,
      'preview': 'assets/themes/theme1.jpg',
      'gradient': LinearGradient(colors: [
        Colors.green.withOpacity(0.1),
        Colors.red.withOpacity(0.3),
      ], begin: Alignment.topLeft, end: Alignment.bottomLeft),
    },
    {
      'name': 'Azaadi Theme 2',
      'isDefault': false,
      'showType': true,
      'isPaid': true,
      'canBuy': true,
      'index': 2,
      'preview': 'assets/themes/theme2.jpg',
      'gradient': LinearGradient(colors: [
        Colors.white.withOpacity(0.1),
        Colors.green.withOpacity(0.4),
      ], stops: [
        0.1,
        0.8
      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
    }
  ];
  static List<Widget> _homeScreens = [
    DefaultHomeScreen(),
    HomeTheme1(),
    HomeTheme2()
  ];
  static Widget showHomeScreen() {
    int index = HiveController.getTheme;
    bool isPremium = HiveController.getIsPremium;
    if (!isPremium) {
      HiveController.setTheme = 0;
      return _homeScreens[0];
    }
    return _homeScreens[index];
  }
}
