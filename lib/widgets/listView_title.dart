import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewTitle extends StatelessWidget {
  ListViewTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ptSans(
          textStyle: TextStyle(
        fontSize: 18,
      )),
    );
  }
}
