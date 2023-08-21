import 'package:flutter/material.dart';

///App colors
abstract final class AppColors {
  static const _purple = 0xFF5A189A;

  ///
  static Color get raisinBlack => const Color(0xFF18121F);

  ///
  static Color get darkGrey => const Color(0xFF111115);

  ///Purple color variations
  static MaterialColor get purple => const MaterialColor(
        _purple,
        <int, Color>{
          200: Color(0xFFE0AAFF),
          300: Color(0xFFC77DFF),
          400: Color(0xFF9D4EDD),
          500: Color(0xFF7B2CBF),
          600: Color(_purple),
          700: Color(0xFF3C096C),
          800: Color(0xFF240046),
          900: Color(0xFF10002B),
        },
      );
}
