import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand / Primary
  static const primary = Color(0xFF64A782); 
  static const primaryLight = Color(0xFFE4F1EA); 

  // Secondary / Accent
  static const secondary = Color(0xFFEBBC54); 
  static const secondaryLight = Color(0xFFFEF1CC);

  // Brand extended
  static const navy = Color(0xFF2F314A);
  static const peach = Color(0xFFF4D2AA);
  static const lavender = Color(0xFFC4B1C5);

  // Neutral / Greys
  static const grey0 = Color(0xFFFFFFFF);
  static const grey50 = Color(0xFFF9FAFB);
  static const grey100 = Color(0xFFF3F4F6);
  static const grey200 = Color(0xFFE5E7EB);
  static const grey300 = Color(0xFFD1D5DB);
  static const grey400 = Color(0xFF9CA3AF);
  static const grey500 = Color(0xFF6B7280);
  static const grey600 = Color(0xFF4B5563);
  static const grey700 = Color(0xFF374151);
  static const grey800 = Color(0xFF1F2937);
  static const grey900 = Color(0xFF111827);

  // Semantic
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFA70000); 
  static const info = Color(0xFF0EA5E9); 

  // Background / Surfaces (single light theme for now)
  static const background = Color.fromRGBO(244, 245, 240, 1);
  static const surface = grey0;
}

// Font family constant.
const kFontFamily = 'Inter';

/// Base text theme using Inter font (single light palette).
TextTheme _buildBaseTextTheme(ColorScheme scheme) {
  const onBgColor = Colors.black;
  // const secondaryText = AppColors.grey600;
  return const TextTheme(
    displayLarge: TextStyle(fontFamily: kFontFamily, fontSize: 57, fontWeight: FontWeight.w600, height: 1.12, letterSpacing: -0.25, color: onBgColor),
    displayMedium: TextStyle(fontFamily: kFontFamily, fontSize: 64, fontWeight: FontWeight.w600, height: 1.15, letterSpacing: 0, color: onBgColor),
    displaySmall: TextStyle(fontFamily: kFontFamily, fontSize: 36, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: 0, color: onBgColor),
    headlineLarge: TextStyle(fontFamily: kFontFamily, fontSize: 32, fontWeight: FontWeight.w600, height: 1.25, letterSpacing: 0, color: onBgColor),
    headlineMedium: TextStyle(fontFamily: kFontFamily, fontSize: 28, fontWeight: FontWeight.w600, height: 1.25, letterSpacing: 0, color: onBgColor),
    headlineSmall: TextStyle(fontFamily: kFontFamily, fontSize: 24, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: 0, color: onBgColor),
    titleLarge: TextStyle(fontFamily: kFontFamily, fontSize: 20, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: 0, color: onBgColor),
    titleMedium: TextStyle(fontFamily: kFontFamily, fontSize: 16, fontWeight: FontWeight.w600, height: 1.35, letterSpacing: 0.15, color: onBgColor),
    titleSmall: TextStyle(fontFamily: kFontFamily, fontSize: 14, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: 0.1, color: onBgColor),
    bodyLarge: TextStyle(fontFamily: kFontFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.15, color: onBgColor),
    bodyMedium: TextStyle(fontFamily: kFontFamily, fontSize: 14, fontWeight: FontWeight.w400, height: 1.45, letterSpacing: 0.25, color: onBgColor),
    bodySmall: TextStyle(fontFamily: kFontFamily, fontSize: 12, fontWeight: FontWeight.w400, height: 1.4, letterSpacing: 0.4, color: onBgColor),
    labelLarge: TextStyle(fontFamily: kFontFamily, fontSize: 14, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: 0.1, color: onBgColor),
    labelMedium: TextStyle(fontFamily: kFontFamily, fontSize: 12, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: 0.5, color: onBgColor),
    labelSmall: TextStyle(fontFamily: kFontFamily, fontSize: 11, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: 0.5, color: onBgColor),
  );
}

/// Single app theme configuration (light only for now)
ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    error: AppColors.error,
  );

  return ThemeData(
    useMaterial3: true,
    fontFamily: kFontFamily,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _buildBaseTextTheme(colorScheme),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      foregroundColor: AppColors.grey900,
      titleTextStyle: _buildBaseTextTheme(colorScheme).titleLarge,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _buildBaseTextTheme(colorScheme).bodyLarge?.copyWith(color: Colors.black),
      prefixIconColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontFamily: kFontFamily, fontWeight: FontWeight.w600, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryLight,
      selectedColor: AppColors.primary,
      labelStyle: const TextStyle(fontFamily: kFontFamily, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: const BorderSide(color: AppColors.primaryLight),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(0),
    ),
  );
}

extension ThemeContextColors on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;  
  Color get successColor => AppColors.success;
  Color get warningColor => AppColors.warning;
  Color get errorColor => AppColors.error;
  Color get infoColor => AppColors.info;
}
