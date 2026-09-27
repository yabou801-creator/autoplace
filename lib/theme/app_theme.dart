// THEME LOCK: light — source: user prompt (white background, #00A99D teal, #0A2540 navy)
// Scaffold.backgroundColor = AppTheme.backgroundLight — ALL screens

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colors
  static const Color primary = Color(0xFF00A99D);
  static const Color primaryDark = Color(0xFF007F76);
  static const Color primaryContainer = Color(0xFFB2F0EC);
  static const Color navy = Color(0xFF0A2540);
  static const Color navyLight = Color(0xFF1A3A5C);

  // Semantic colors
  static const Color success = Color(0xFF2D7A4F);
  static const Color warning = Color(0xFFB45309);
  static const Color error = Color(0xFFB91C1C);
  static const Color whatsappGreen = Color(0xFF25D366);

  // Light surfaces
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color mutedText = Color(0xFF8A9BB0);
  static const Color borderColor = Color(0xFFE2E8F0);

  // Dark surfaces
  static const Color surfaceDark = Color(0xFF1E2A3A);
  static const Color backgroundDark = Color(0xFF0D1B2A);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryContainer,
      onPrimaryContainer: navy,
      secondary: navy,
      onSecondary: Colors.white,
      surface: surfaceLight,
      onSurface: const Color(0xFF1A2332),
      error: error,
      onError: Colors.white,
      outline: borderColor,
      outlineVariant: const Color(0xFFF0F4F8),
    ),
    scaffoldBackgroundColor: backgroundLight,
    textTheme: GoogleFonts.dmSansTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: navy,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: navy,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: navy,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: navy,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: navy,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF334155),
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF334155),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: mutedText,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: navy,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: GoogleFonts.dmSans(fontSize: 14, color: mutedText),
      hintStyle: GoogleFonts.dmSans(fontSize: 14, color: mutedText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(double.infinity, 52),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: backgroundLight,
      selectedColor: primary,
      labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFF004F4A),
      onPrimaryContainer: const Color(0xFFB2F0EC),
      secondary: const Color(0xFF4A8FBF),
      onSecondary: Colors.white,
      surface: surfaceDark,
      onSurface: const Color(0xFFE6EDF5),
      error: const Color(0xFFCF6679),
      onError: Colors.white,
      outline: const Color(0xFF2A3A4A),
      outlineVariant: const Color(0xFF1A2A3A),
    ),
    scaffoldBackgroundColor: backgroundDark,
    textTheme: GoogleFonts.dmSansTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE6EDF5),
        ),
      ),
    ),
  );
}
