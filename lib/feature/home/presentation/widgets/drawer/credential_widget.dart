import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/hero_dialog_route.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home_drawer/home_drawer_store.dart';

///Widget shown when credentials exists
class CredentialWidget extends StatelessWidget {
  ///Constructor
  const CredentialWidget({
    super.key,
    required this.profileImgUrl,
    required this.nickname,
    required this.userProfileUrl,
  });

  final String profileImgUrl;
  final String nickname;
  final String userProfileUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final copiedAnimation = theme.brightness == Brightness.dark
        ? AppAssets.copiedAnimationDark
        : AppAssets.copiedAnimationLight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Hero(
                  tag: profileImgUrl,
                  child: AnimatedContainer(
                    duration: 1000.ms,
                    child: ImageWidget(
                      url: profileImgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          child: Hero(
            tag: profileImgUrl,
            child: AnimatedContainer(
              height: 60,
              width: 60,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              duration: 1000.ms,
              child: ImageWidget(
                url: profileImgUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          nickname,
          style: theme.textTheme.bodyLarge,
        ),
        SizedBox(
          height: 24,
          child: Observer(
            builder: (context) {
              final isUrlCopied = context.read<HomeDrawerStore>().isUrlCopied;
              if (isUrlCopied) {
                return Row(
                  children: [
                    Text(
                      userProfileUrl,
                      style: theme.textTheme.labelSmall,
                    ),
                    _CopiedAnimation(
                      copiedAnimation,
                    ),
                  ],
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    context.read<HomeDrawerStore>().copied();
                    Clipboard.setData(
                      ClipboardData(
                        text: userProfileUrl,
                      ),
                    );
                    Future.delayed(
                      const Duration(seconds: 2),
                      () => context.read<HomeDrawerStore>().copied(),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        userProfileUrl,
                        style: theme.textTheme.labelSmall,
                      ),
                      _CopiedAnimation(
                        copiedAnimation,
                        isAnimated: false,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _CopiedAnimation extends StatelessWidget {
  const _CopiedAnimation(
    this.assetName, {
    super.key,
    this.isAnimated = true,
  });

  final String assetName;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      assetName,
      repeat: false,
      animate: isAnimated,
      height: 24,
    );
  }
}
