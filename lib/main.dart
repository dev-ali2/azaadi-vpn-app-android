import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/pages/splash_page.dart';
import 'package:azaadi_vpn_android/pages/temp_notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:azaadi_vpn_android/STARTER/helpers/pref.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/services/vpn_engine.dart';
import 'package:azaadi_vpn_android/controller/home_controller.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controller/dotenv_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotenvController.initDotenv();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await HiveController.initializeHive();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  NotificationController.initNotificationService();
  //testing functions

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumController = Get.put(PremiumController());
    final hapticController = Get.put(HapticController());
    final notificationController = Get.put(NotificationController());
    final hiveController = Get.put(HiveController());
    final connectionController = Get.put(ConnectionController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DefaultTheme.lightTheme,
      darkTheme: DefaultTheme.darkTheme,
      themeMode: ThemeMode.dark,
      title: 'Azaadi Vpn',
      // home: HomeScreen(),
      // home: DefaultHomeScreen(),
      home: SplashPage(),
      // home: TempNotificationsPage()
    );
  }
}
