import 'package:azaadi_vpn_android/components02/settings_icon.dart';
import 'package:azaadi_vpn_android/components02/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppbar1 extends StatelessWidget {
  const CustomAppbar1({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SizedBox(
      height: size.height * 0.1,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleText1(),
          SettingsIcon1(),
        ],
      ),
    ));
  }
}
