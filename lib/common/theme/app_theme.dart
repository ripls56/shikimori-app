import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shikimoriapp/common/theme/app_colors.dart';

///App theme
abstract final class AppTheme {
  ///Dark theme
  static ThemeData get darkTheme => _defaultDarkTheme;

  ///Light theme
  static ThemeData get lightTheme => _defaultLightTheme;

  ///User custom theme
  static ThemeData userTheme({
    Color? color,
    Brightness? brightness,
  }) =>
      _userTheme(
        color: color,
        brightness: brightness,
      );
}

ThemeData _userTheme({
  Color? color,
  Brightness? brightness,
}) =>
    ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color ?? Colors.lightBlueAccent,
        brightness: brightness ?? Brightness.light,
      ),
    );

ThemeData _defaultDarkTheme = ThemeData(
  textTheme: TextTheme(
    bodySmall: GoogleFonts.openSansTextTheme().bodySmall?.copyWith(
          color: AppColors.purple.shade50,
          fontSize: 12,
        ),
    bodyMedium: GoogleFonts.openSansTextTheme().bodyMedium?.copyWith(
          color: AppColors.purple.shade50,
          fontSize: 14,
        ),
    bodyLarge: GoogleFonts.openSansTextTheme().bodyLarge?.copyWith(
          color: AppColors.purple.shade50,
          fontSize: 16,
        ),
    headlineSmall: GoogleFonts.openSansTextTheme().headlineSmall?.copyWith(
          color: AppColors.purple.shade50,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
    headlineMedium: GoogleFonts.openSansTextTheme().headlineMedium?.copyWith(
          color: AppColors.purple.shade50,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
    headlineLarge: GoogleFonts.openSansTextTheme().headlineLarge?.copyWith(
          color: AppColors.purple.shade50,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
  ),
  iconTheme: IconThemeData(
    color: AppColors.purple.shade50,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        AppColors.purple.shade50,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        AppColors.purple.shade50,
      ),
    ),
  ),
  colorScheme: ColorScheme.dark(
    background: AppColors.darkGrey,
    primary: AppColors.purple.shade300,
    onSurface: AppColors.purple.shade50,
    secondary: AppColors.raisinBlack,
    onSecondary: AppColors.purple.shade50,
    primaryContainer: AppColors.purple.shade800,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.purple.shade900,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.purple.shade100,
  ),
  scaffoldBackgroundColor: AppColors.darkGrey,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
);

ThemeData _defaultLightTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  brightness: Brightness.light,
  primaryColor: AppColors.purple,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
  ),
  useMaterial3: true,
);
