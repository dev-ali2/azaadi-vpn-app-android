import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:azaadi_vpn_android/controller/premium_controller.dart';
import 'package:azaadi_vpn_android/core/models/services/vpn_engine.dart';
import 'package:azaadi_vpn_android/core/models/vpn_status.dart';
import 'package:azaadi_vpn_android/pages/settings_info_page.dart';
import 'package:azaadi_vpn_android/pages/temp_servers_page.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:azaadi_vpn_android/widgets/buy_premium_dialog.dart';
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
import 'package:flutter/widgets.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:azaadi_vpn_android/pages/locations_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final premiumController = Get.find<PremiumController>();
  final hapticController = Get.find<HapticController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
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
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.003, horizontal: 10),
                      child: Container(
                          height: size.height * 0.08,
                          width: double.infinity,
                          child: ListTile(
                            leading: Icon(
                              LucideIcons.crown,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            trailing: Switch(
                              inactiveThumbColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                              inactiveTrackColor: Colors.black.withOpacity(0.1),
                              value: premiumController.isPremium.value,
                              onChanged: (value) {
                                premiumController.changePremiumStatus(value);
                              },
                            ),
                            title: Text(
                              'Premium mode',
                              style: GoogleFonts.ptSans(
                                  textStyle: TextStyle(
                                fontSize: 18,
                              )),
                            ),
                          )),
                    ),
                  ),
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
                        String termsOfUse = await HiveController.getTermsOfUse;

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
    );
  }
}
