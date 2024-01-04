import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/widgets/headline_button.dart';

///Sliver header delegate for use with
///[SliverMainAxisGroup]
class HeadlineHeaderDelegate extends SliverPersistentHeaderDelegate {
  ///Constructor
  const HeadlineHeaderDelegate({
    required this.title,
    required this.onTap,
  });

  ///Headline title
  final String title;

  ///Headline on tap callback
  final VoidCallback onTap;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return HeadlineButton(
      title: title,
      onTap: onTap,
    );
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 34;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
