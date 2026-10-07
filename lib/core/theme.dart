import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF9669B6); // Amethyst Purple
  static const Color secondary = Color(0xFFE74C3C); // Soft Crimson
  static const Color background = Color(0xFFFDFEFE);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        fontFamily: 'AppSans',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.w800),
          bodyMedium: TextStyle(fontWeight: FontWeight.w400),
          labelSmall: TextStyle(fontWeight: FontWeight.w300),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          secondary: secondary,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 6,
          color: Colors.white,
          shadowColor: primary.withValues(alpha: 0.45),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
}
