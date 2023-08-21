import 'package:flutter/widgets.dart';

///Scroll without splash
class ScrollWithoutSplash extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
