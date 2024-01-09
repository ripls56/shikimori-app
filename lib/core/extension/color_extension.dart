import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

///Color extension
extension ColorWithHSL on Color {
  HSLColor get hsl => HSLColor.fromColor(this);

  ///Return a new color with specified [saturation]
  Color withSaturation(double saturation) {
    return hsl
        .withSaturation(
          clampDouble(saturation, 0, 1),
        )
        .toColor();
  }

  ///Return a new color with specified [lightness]
  Color withLightness(double lightness) {
    return hsl
        .withLightness(
          clampDouble(lightness, 0, 1),
        )
        .toColor();
  }

  ///Return a new color with specified [hue]
  Color withHue(double hue) {
    return hsl
        .withHue(
          clampDouble(hue, 0, 360),
        )
        .toColor();
  }
}
