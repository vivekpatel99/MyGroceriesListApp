import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODo add theme of all the components here
class MyTheme {
  MyTheme._();
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        accentColor: Colors.deepPurpleAccent,
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: Brightness.dark,
      );
}
