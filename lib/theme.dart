import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant Blinkit Yellow
  static const Color primaryColor = Color(0xFFF8CB46); 
  // Deep Action Green for Buttons/Prices
  static const Color accentGreen = Color(0xFF0C831F);
  static const Color offerRed = Color(0xFFE53935);
  
  static const Color backgroundColor = Color(0xFFF4F6F9); 
  static const Color surfaceColor = Colors.white;
  static const Color textDark = Color(0xFF1C1C1C);
  static const Color textLight = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        primary: primaryColor,
        secondary: accentGreen,
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(color: textDark, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.outfit(color: textDark, fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.outfit(color: textDark, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.outfit(color: textDark),
        bodyMedium: GoogleFonts.outfit(color: textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: textLight, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      cardTheme: const CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
