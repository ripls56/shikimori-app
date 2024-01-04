// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'action_button_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ActionButtonThemeTailorMixin on ThemeExtension<ActionButtonTheme> {
  TextStyle get labelTextStyle;

  Color get iconColor;

  @override
  ActionButtonTheme copyWith({
    TextStyle? labelTextStyle,
    Color? iconColor,
  }) {
    return ActionButtonTheme(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ActionButtonTheme lerp(
      covariant ThemeExtension<ActionButtonTheme>? other, double t) {
    if (other is! ActionButtonTheme) return this as ActionButtonTheme;
    return ActionButtonTheme(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionButtonTheme &&
            const DeepCollectionEquality()
                .equals(labelTextStyle, other.labelTextStyle) &&
            const DeepCollectionEquality().equals(iconColor, other.iconColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(labelTextStyle),
      const DeepCollectionEquality().hash(iconColor),
    );
  }
}

extension ActionButtonThemeBuildContextProps on BuildContext {
  ActionButtonTheme get actionButtonTheme =>
      Theme.of(this).extension<ActionButtonTheme>()!;

  ///Label text style
  TextStyle get labelTextStyle => actionButtonTheme.labelTextStyle;

  ///Icon color
  Color get iconColor => actionButtonTheme.iconColor;
}
