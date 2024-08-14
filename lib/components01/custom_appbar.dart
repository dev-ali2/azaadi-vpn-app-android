import 'package:flutter/material.dart';

import 'package:azaadi_vpn_android/components01/settings_icon.dart';
import 'package:azaadi_vpn_android/components01/title_text.dart';

// import 'package:purchases_flutter/models/offerings_wrapper.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

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
          TitleText(),
          SettingsIcon(),
        ],
      ),
    ));
  }
}
