import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key, required this.text, required this.onTap, this.color});
  final String text;
  Color? color;
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
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color != null ? color : null),
              ))),
    );
  }
}
