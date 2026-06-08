import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(bool isArabic) => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF7F73E6),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF7F73E6),
      secondary: Color(0xFF7F73E6),
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xff2B1E5E),
      elevation: 0,
    ),
    cardColor: Colors.white,
    textTheme: isArabic
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.poppinsTextTheme(),
  );

  static ThemeData darkTheme(bool isArabic) => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F0F1A),
    primaryColor: const Color(0xFF7F73E6),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7F73E6),
      secondary: Color(0xFF7F73E6),
      surface: Color(0xFF1A1A2E),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F0F1A),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: const Color(0xFF1A1A2E),
    textTheme: isArabic
        ? GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)
        : GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );
}
