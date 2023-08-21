import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/theme/app_theme.dart';

/// Theme provider for switch theme between dark and light
class ThemeProvider extends ChangeNotifier {
  // /// Theme mode
  // ThemeMode themeMode = ThemeMode.dark;

  ///Boolean value to check if dark mode is enabled
  // bool get isDarkMode => themeMode == ThemeMode.dark;

  ///App theme
  ThemeData appTheme = AppTheme.darkTheme;

  Color? _userColor;

  bool _isDark = false;

  /// Change theme mode
  void changeTheme() {
    _isDark = !_isDark;
    if (_userColor == null) {
      appTheme = _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
    } else {
      appTheme = AppTheme.userTheme(
        color: _userColor,
        brightness: _isDark ? Brightness.dark : Brightness.light,
      );
    }
    notifyListeners();
  }

  ///Change app theme to custom user theme created based on passed color
  void changeToUserTheme(Color color, {Brightness? brightness}) {
    _userColor = color;
    appTheme = AppTheme.userTheme(color: color, brightness: brightness);
    notifyListeners();
  }
}
