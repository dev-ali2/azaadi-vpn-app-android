import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/models/themes_list.dart';
import 'package:azaadi_vpn_android/widgets/theme_info_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colors = Get.find<ColorController>();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Azaadi Themes',
            style: GoogleFonts.ptSans(
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(gradient: colors.pageGradient()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height * 0.85,
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: ThemeInfoContainer(
                      current: HiveController.getTheme,
                      index: index,
                      info: ThemesList.themesInfo[index],
                    ),
                  ),
                  itemCount: ThemesList.themesInfo.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.015),
                child: Text(
                  'More themes coming soon...',
                  style: GoogleFonts.ptSans(
                      textStyle: TextStyle(
                    overflow: TextOverflow.fade,
                    fontSize: 15,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
