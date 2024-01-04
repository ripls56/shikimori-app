import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/dimension.dart';
import 'package:shikimoriapp/core/helpers/home_card_type.dart';

///Home card widget
class HomeCard extends StatelessWidget {
  ///Constructor
  const HomeCard({
    required this.url,
    required this.title,
    required this.cardType,
    this.onTap,
    super.key,
  });

  final String url;

  final String title;

  final HomeCardType cardType;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AspectRatio(
      aspectRatio: 10 / 16,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimension.borderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ImageWidget(
                    url: url,
                    fadeInDuration: const Duration(milliseconds: 100),
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: ColoredBox(
                    color: theme.colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.bodySmall?.copyWith(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(Dimension.borderRadius),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(Dimension.borderRadius),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
