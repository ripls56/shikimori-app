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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.03),
                    spreadRadius: 3,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimension.borderRadius),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ImageWidget(
                        url: url,
                        fit: BoxFit.cover,
                        width: 200,
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: AspectRatio(
                        aspectRatio: 16 / 4,
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
                                style: context.theme.textTheme.bodySmall
                                    ?.copyWith(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
