import 'package:azaadi_vpn_android/controller/ad_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/pages/splash_page.dart';
import 'package:azaadi_vpn_android/pages/terms_accept_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'controller/dotenv_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await DotenvController.initDotenv();
  await HiveController.initializeHive();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  NotificationController.initNotificationService();
  AdController.initAdService();
  PremiumController.initInAppPurchases();
  // PremiumController.initInAppPurchasesRevenueCat();
  if (kDebugMode) {
    WakelockPlus.enable();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late StreamSubscription<List<PurchaseDetails>> streamSubscription;

  @override
  void initState() {
    super.initState();
//? this code will listen to in app purchases stream like if purchase is pending or done or cancelled
    // final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    // streamSubscription = purchaseUpdated.listen((purchadeDetailsList) {
    //   PremiumController.listenToPurchasesInStore(purchadeDetailsList);
    // }, onDone: () {
    //   streamSubscription.cancel();
    // }, onError: (e) {
    //   streamSubscription.cancel();
    // }) as StreamSubscription<List<PurchaseDetails>>;
  }

  @override
  Widget build(BuildContext context) {
    bool termsAccepted = HiveController.getTermsStatus;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DefaultTheme.lightTheme,
      darkTheme: DefaultTheme.darkTheme,
      themeMode: ThemeMode.dark,
      title: 'Azaadi Vpn',
      // home: HomeScreen(),
      // home: DefaultHomeScreen(),
      home: termsAccepted ? SplashPage() : TermsAcceptPage(),
      // home: TempNotificationsPage()
    );
  }
}
