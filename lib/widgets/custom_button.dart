import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.onTap});
  final String text;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: TextButton(
          onPressed: onTap,
          child: Text(text,
              style: GoogleFonts.ptSans(
                textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ))),
    );
  }
}
