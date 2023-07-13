import 'package:flutter/material.dart';

///Extension to get screen size (syntactic sugar)
extension Screen on BuildContext {
  ///Get screen height by use [MediaQuery]
  double get screenHeight => MediaQuery.of(this).size.height;

  ///Get screen width by use [MediaQuery]
  double get screenWidth => MediaQuery.of(this).size.width;
}
