import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/widgets/headline_button.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

///Sliver header delegate for use with
///[SliverMainAxisGroup]
class HeadlineHeaderDelegate extends SliverPersistentHeaderDelegate {
  ///Constructor
  const HeadlineHeaderDelegate({
    required this.title,
    required this.onTap,
    required this.minimalExtent,
    this.padding,
  });

  ///Headline title
  final String title;

  ///Headline on tap callback
  final VoidCallback onTap;

  ///Height of headline delegate
  final double minimalExtent;

  final EdgeInsets? padding;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = context.theme;
    return Center(
      child: HeadlineButton(
        label: title,
        onTap: onTap,
        height: minimalExtent,
        padding: padding,
      ),
    );
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => minimalExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
