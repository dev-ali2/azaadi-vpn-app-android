import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewSubtitle extends StatelessWidget {
  ListViewSubtitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      text,
      style: GoogleFonts.ptSans(
          textStyle: TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 12,
              color: Theme.of(context).colorScheme.secondary)),
    );
  }
}
