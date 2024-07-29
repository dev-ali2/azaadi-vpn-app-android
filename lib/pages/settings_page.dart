import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/pages/settings_info_page.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:azaadi_vpn_android/widgets/custom_button.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/about_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/azaadi_themes_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/change_location_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/faq_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/haptic_feedback_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/notifications_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/report_bug_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/restore_purchase_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_options/validate_locations_option.dart';
import 'package:azaadi_vpn_android/widgets/settings_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final premiumController = Get.find<PremiumController>();
  final hapticController = Get.find<HapticController>();
  final colors = Get.find<ColorController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: colors.pageGradient(),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.3,
              pinned: true,
              backgroundColor: Colors.black.withOpacity(0.7),
              flexibleSpace: Center(
                child: Text(
                  'Settings',
                  style: GoogleFonts.ptSans(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                child: Column(
                  children: [
                    SettingsTitles(
                      text: 'Exclusive 👑',
                      color: AppColors.premiumText,
                    ),
                    //Azaadi themes
                    AzaadiThemesOption(),
                    Divider(
                      indent: size.width * 0.2,
                    ),
                    SettingsTitles(
                      text: 'Connection',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    // Connection
                    NotificationsOption(),
                    ChangeLocationOption(),
                    ValidateLocationsOption(),
                    Divider(
                      indent: size.width * 0.2,
                    ),
                    //App settings
                    SettingsTitles(
                      text: 'Application',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    HapticFeedbackOption(),
                    ReportBugOption(),
                    Divider(
                      indent: size.width * 0.2,
                    ),
                    // Miscellaneous
                    SettingsTitles(
                      text: 'Miscellaneous',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    RestorePurchaseOption(),
                    FaqOption(),
                    AboutOption(),
                    //share app
                    CustomButton(
                        text: 'Share app',
                        onTap: () {
                          Share.share(
                              'Hey, I just found a great vpn app on playstore, do check it out right now and enjoy censorship free and secure browsing\nhttps://play.google.com/store/apps/details?id=com.azaadi.vpn.android.app');
                        }),
                    //rate app
                    CustomButton(
                        text: 'Rate on playstore',
                        onTap: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.azaadi.vpn.android.app');
                        }),
                    //termsof use
                    CustomButton(
                        text: 'Terms of use',
                        onTap: () async {
                          hapticController.provideFeedback(FeedbackType.light);
                          String termsOfUse =
                              await HiveController.getTermsOfUse;

                          Get.to(
                              transition: Transition.cupertino,
                              () => SettingsInfoPage(
                                  title: 'Terms of use',
                                  description: termsOfUse));
                        }),
                    //privacy policy
                    CustomButton(
                        text: 'Privacy policy',
                        onTap: () async {
                          hapticController.provideFeedback(FeedbackType.light);
                          String privacyPolicy =
                              await HiveController.getPrivacyPolicy;

                          Get.to(
                              transition: Transition.cupertino,
                              () => SettingsInfoPage(
                                  title: 'Privacy Policy',
                                  description: privacyPolicy));
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
