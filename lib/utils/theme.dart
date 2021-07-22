import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData darkTheme(BuildContext context) => ThemeData(
      accentColor: Colors.deepPurpleAccent,
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark);
}
