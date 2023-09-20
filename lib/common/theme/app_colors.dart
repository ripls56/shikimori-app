import 'package:flutter/material.dart';

///App colors
abstract final class AppColors {
  static const _purple = 0xFF5A189A;

  ///Color for all shadows
  static Color get shadowColor => const Color(0xFF272731);

  ///
  static Color get raisinBlack => const Color(0xFF18121F);

  ///
  static Color get darkGrey => const Color(0xFF09020f);

  ///Purple color variations
  static MaterialColor get purple => const MaterialColor(
        _purple,
        <int, Color>{
          50: Color(0xfffceeff),
          100: Color(0xFFEED1FB),
          200: Color(0xFFE0AAFF),
          300: Color(0xFFC77DFF),
          400: Color(0xFF9D4EDD),
          500: Color(0xFF7B2CBF),
          600: Color(_purple),
          700: Color(0xFF451276),
          800: Color(0xFF2B0b4A),
          900: Color(0xFF1A072C), //0xFF10002B
        },
      );
}
