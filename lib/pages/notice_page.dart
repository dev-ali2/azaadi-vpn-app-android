import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticePage extends StatelessWidget {
  NoticePage(
      {super.key,
      required this.description,
      required this.subtitle,
      required this.title,
      required this.showButton});

  final String description;
  final String title;
  final String subtitle;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colors = Get.find<ColorController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )),
        ),
      ),
      body: Center(
        child: Container(
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: colors.appFootergradient(context),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.025),
                    child: Text(
                      subtitle,
                      style: GoogleFonts.ptSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.64,
                          child: Text(
                            softWrap: true,
                            '${description.replaceAll('/', '\n\n')}',
                            style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                                    fontSize: 18, overflow: TextOverflow.clip)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showButton
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.05,
                              bottom: size.height * 0.02),
                          child: ElevatedButton(
                              onPressed: () {
                                Get.offAll(() => DefaultHomeScreen());
                              },
                              child: Text('Got it')),
                        )
                      : SizedBox(
                          height: size.height * 0.06,
                        )
                ],
              ),
            )),
      ),
    );
  }
}
