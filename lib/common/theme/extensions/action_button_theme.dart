import 'package:flutter/material.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/widgets/action_button.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'action_button_theme.tailor.dart';

///Theme extension for [ActionButton]
@TailorMixin()
class ActionButtonTheme extends ThemeExtension<ActionButtonTheme>
    with _$ActionButtonThemeTailorMixin {
  ///
  const ActionButtonTheme({
    required this.labelTextStyle,
    required this.iconColor,
  });

  ///Label text style
  @override
  final TextStyle labelTextStyle;

  ///Icon color
  @override
  final Color iconColor;
}
