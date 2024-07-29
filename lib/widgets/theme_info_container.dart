import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/models/themes_list.dart';
import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:azaadi_vpn_android/widgets/buy_premium_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ThemeInfoContainer extends StatefulWidget {
  ThemeInfoContainer(
      {super.key,
      required this.info,
      required this.index,
      required this.current});
  final Map<String, dynamic> info;
  final int index;
  final int current;

  @override
  State<ThemeInfoContainer> createState() => _ThemeInfoContainerState();
}

class _ThemeInfoContainerState extends State<ThemeInfoContainer> {
  final hapticController = Get.find<HapticController>();
  bool isApplying = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: widget.info['gradient']),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.info['preview'],
                  height: size.height * 0.35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: Text(
                      widget.info['name'],
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(fontSize: 15)),
                          children: [
                            TextSpan(
                              text: 'Type : ',
                            ),
                            TextSpan(
                                text: widget.info['isDefault']
                                    ? 'Stock theme'
                                    : widget.info['isPaid']
                                        ? 'Premium'
                                        : 'Free',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.premiumText),
                                )),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: !isApplying
                        ? ElevatedButton(
                            onPressed: widget.current != widget.index
                                ? () async {
                                    if (widget.current != widget.index) {
                                      hapticController
                                          .provideFeedback(FeedbackType.light);
                                    }
                                    if (HiveController.getIsPremium) {
                                      isApplying = true;
                                      setState(() {});

                                      await Future.delayed(
                                          Duration(seconds: 3));
                                      HiveController.setTheme = widget.index;

                                      Get.back();
                                      await Future.delayed(
                                          Duration(milliseconds: 300));
                                      Get.back();
                                      await Future.delayed(
                                          Duration(milliseconds: 400));

                                      Get.offAll(
                                          transition: Transition.circularReveal,
                                          duration:
                                              Duration(milliseconds: 1600),
                                          () => ThemesList.showHomeScreen());
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            BuyPremiumDialog(),
                                      );
                                    }
                                  }
                                : null,
                            child: Text(widget.info['isDefault'] ||
                                    HiveController.getIsPremium
                                ? 'Apply'
                                : 'Unlock'))
                        : LoadingAnimationWidget.staggeredDotsWave(
                            color: Theme.of(context).colorScheme.primary,
                            size: 35),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
