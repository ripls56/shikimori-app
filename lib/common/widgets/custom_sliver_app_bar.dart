import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shikimoriapp/common/theme/app_colors.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  ///
  const CustomSliverAppBar({
    required this.child,
    this.title,
    this.background,
    this.expandedHeight = 300,
  }) : assert(
          expandedHeight != null && expandedHeight >= kToolbarHeight,
          'Maximum expanded height can`t be null, '
          'or less then [kToolbarHeight]',
        );

  final double? expandedHeight;

  final Widget child;

  final Widget? background;

  final String? title;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: kToolbarHeight,
        maxHeight: expandedHeight!,
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            if (background != null) background!,
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: const SizedBox.shrink(),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: Opacity(
                opacity: clampDouble(
                  1 - shrinkOffset / expandedHeight! * 5,
                  0,
                  1,
                ),
                child: shrinkOffset != 0
                    ? Transform.scale(
                        scale: clampDouble(
                          1 - shrinkOffset / expandedHeight!,
                          0.7,
                          1,
                        ),
                        child: child,
                      )
                    : child,
              ),
            ),
            Positioned(
              top: kToolbarHeight,
              width: context.screenWidth,
              child: Row(
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  IconButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.purple.shade50,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 8),
                      child: Opacity(
                        opacity: clampDouble(
                          shrinkOffset / expandedHeight! * 2,
                          0,
                          1,
                        ),
                        child: Text(
                          title ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style:
                              context.theme.textTheme.headlineSmall?.copyWith(
                            color: AppColors.purple.shade50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight * 2;

  @override
  bool shouldRebuild(covariant CustomSliverAppBar oldDelegate) {
    return true;
  }
}
