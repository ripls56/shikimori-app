import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

///Animations for all list views in the app
abstract class ListAnimationConfiguration extends StatelessWidget {
  ///Constructor for list view
  const ListAnimationConfiguration({
    required this.index,
    required this.child,
    required this.delay,
    required this.duration,
    super.key,
  });

  ///Horizontal animation configuration
  factory ListAnimationConfiguration.horizontal({
    required int index,
    required Widget child,
    Key? key,
    Duration? delay,
    Duration? duration,
  }) =>
      _HorizontalListAnimationConfiguration(
        key: key,
        index: index,
        delay: delay,
        duration: duration,
        child: child,
      );

  ///Vertical animation configuration
  factory ListAnimationConfiguration.vertical({
    required int index,
    required Widget child,
    Key? key,
    Duration? delay,
    Duration? duration,
  }) =>
      _VerticalListAnimationConfiguration(
        key: key,
        index: index,
        delay: delay,
        duration: duration,
        child: child,
      );

  ///Index of item
  final int index;

  ///Child widget
  final Widget child;

  ///The delay between the beginning of two children's animations
  final Duration? delay;

  ///The duration of the animation
  final Duration? duration;
}

class _HorizontalListAnimationConfiguration extends ListAnimationConfiguration {
  const _HorizontalListAnimationConfiguration({
    required super.index,
    required super.child,
    required super.delay,
    required super.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          delay: delay,
          duration: duration,
          verticalOffset: 0,
          horizontalOffset: 50,
          child: FadeInAnimation(
            duration: duration,
            delay: delay,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _VerticalListAnimationConfiguration extends ListAnimationConfiguration {
  const _VerticalListAnimationConfiguration({
    required super.index,
    required super.child,
    required super.delay,
    required super.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          delay: delay,
          duration: duration,
          verticalOffset: 50,
          horizontalOffset: 0,
          child: FadeInAnimation(
            duration: duration,
            delay: delay,
            child: child,
          ),
        ),
      ),
    );
  }
}
