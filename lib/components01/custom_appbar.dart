import 'dart:developer';

import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:azaadi_vpn_android/components01/settings_icon.dart';
import 'package:azaadi_vpn_android/components01/title_text.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

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
