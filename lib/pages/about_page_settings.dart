import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPageSettings extends StatelessWidget {
  AboutPageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final String appVersion =
        HiveController.getDeviceInfo['appVersion'] as String;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About',
          style: GoogleFonts.ptSans(
              textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: size.height * 0.30,
          width: size.width * 0.9,
          child: Stack(children: [
            Positioned(
              bottom: 1,
              child: Container(
                height: size.height * 0.19,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Text(
                      'Azaadi Vpn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text('Version : $appVersion'),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: (size.height * size.width) * 0.00055,
                    height: (size.height * size.width) * 0.00055,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/splash-icon.png')),
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
