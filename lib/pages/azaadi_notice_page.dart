import 'package:azaadi_vpn_android/home/default_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AzaadiNoticePage extends StatelessWidget {
  AzaadiNoticePage({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Azaadi Notice Board',
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
              gradient: LinearGradient(begin: Alignment.centerLeft, colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                Theme.of(context).colorScheme.secondary.withOpacity(0.3)
              ]),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
                  child: Text(
                    'Notice',
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
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, bottom: size.height * 0.02),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => DefaultHomeScreen());
                      },
                      child: Text('Got it')),
                )
              ],
            )),
      ),
    );
  }
}
