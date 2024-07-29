import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle1 extends StatelessWidget {
  const AppTitle1({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black.withOpacity(0.01),
      height: size.height * 0.15,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GradientAnimationText(
                    text: Text(
                      'Azaadi Vpn',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    colors: [
                      // Colors.white,
                      // Colors.white,
                      // Colors.white,
                      Colors.green,
                      Colors.green,

                      Colors.red,
                      Colors.red,
                    ],
                    duration: Duration(seconds: 5)),
              ],
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              'Fight Censorship, Fuel Freedom',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
