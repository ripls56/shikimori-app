import 'package:flutter/material.dart';
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
      colorScheme: ColorScheme.fromSeed(
        seedColor: color ?? Colors.lightBlueAccent,
        brightness: brightness ?? Brightness.light,
      ),
    );

ThemeData _defaultDarkTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
    ),
  ),
  colorScheme: ColorScheme.dark(
    background: AppColors.darkGrey,
    primary: AppColors.purple,
    secondary: AppColors.raisinBlack,
    onSecondary: Colors.white,
    primaryContainer: AppColors.purple.shade700,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.darkGrey,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
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
