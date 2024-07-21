import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTitles extends StatelessWidget {
  const SettingsTitles({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.ptSans(
            textStyle: TextStyle(fontSize: 14, color: color)),
      ),
    );
  }
}
