import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/common/theme/app_colors.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/custom_sliver_app_bar.dart';
import 'package:shikimoriapp/common/widgets/headline_button.dart';
import 'package:shikimoriapp/common/widgets/headline_widget.dart';
import 'package:shikimoriapp/common/widgets/html_description_widget.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';
import 'package:shikimoriapp/core/extension/color_extension.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/extension/string_extension.dart';
import 'package:shikimoriapp/core/helpers/dimension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_roles.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/screenshots_page.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/videos_page.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/widgets/action_button.dart';
import 'package:shikimoriapp/routes.dart';

part '../widgets/anime_information_widget.dart';
part '../widgets/description_widget.dart';
part '../widgets/related_widget.dart';
part '../widgets/roles_widget.dart';
part '../widgets/screenshots/screenshot_widget.dart';
part '../widgets/top/top_widget.dart';
part '../widgets/videos_widget.dart';

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({required int id, super.key}) : _id = id;

  final int _id;

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    context.read<AnimeDetailCubit>().getAnimeDetails(widget._id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocConsumer<AnimeDetailCubit, AnimeDetailState>(
      listener: (context, state) {
        if (state is AnimeDetailError) {
          Future.delayed(
            const Duration(seconds: 5),
            () => context.read<AnimeDetailCubit>().getAnimeDetails(widget._id),
          );
        }
      },
      builder: (context, state) {
        if (state is AnimeDetailLoaded) {
          final animeDetails = state.animeDetails;

          final imageUrl = '${Env.shikimoriUrl}'
              '${animeDetails.image?.original}';

          final palette = state.palette;

          final roles = state.roles;

          final vibrantColor = palette.vibrantColor?.color.withLightness(.6) ??
              palette.mutedColor?.color.withLightness(.6).withSaturation(.6);

          return Scaffold(
            body: SafeArea(
              top: false,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomSliverAppBar(
                      expandedHeight: 700,
                      title: animeDetails.name ?? '',
                      onTitleTap: () => _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                      background: Stack(
                        children: [
                          Positioned.fill(
                            child: ImageWidget(
                              fit: BoxFit.cover,
                              color: const Color(0xFF515151),
                              colorBlendMode: BlendMode.multiply,
                              url: imageUrl,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (context.screenHeight > 700) const Spacer(),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (context.screenHeight < 700) {
                                return ImageWidget(
                                  height: constraints.maxWidth * 0.5,
                                  url: imageUrl,
                                );
                              }
                              return ImageWidget(
                                height: 300,
                                url: imageUrl,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              animeDetails.russian ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: AppColors.purple.shade50,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            animeDetails.name ?? '',
                            style: theme.textTheme.labelSmall?.copyWith(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ActionButton(
                                label: 'Оценить',
                                icon: Icons.star_border,
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    barrierLabel: 'asdasdasdsa',
                                    builder: (context) => Container(),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ActionButton(
                                label: 'Добавить',
                                icon: Icons.bookmark_add_outlined,
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ActionButton(
                                label: 'Поделиться',
                                icon: Icons.share,
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ActionButton(
                                label: 'Еще',
                                icon: Icons.more_vert,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Flexible(
                            child: SizedBox(
                              height: 56,
                              child: ListView.separated(
                                physics: const PageScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                scrollDirection: Axis.horizontal,
                                itemCount: animeDetails.genres.length,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 6,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          Dimension.borderRadius,
                                        ),
                                        child: ColoredBox(
                                          color: Colors.white.withOpacity(.1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              animeDetails
                                                      .genres[index]?.russian ??
                                                  '',
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBarIndicator(
                                unratedColor: palette.mutedColor?.color
                                        .withOpacity(.25) ??
                                    theme.colorScheme.primary.withOpacity(.25),
                                rating: double.parse(
                                      animeDetails.score ?? '5',
                                    ) /
                                    2,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color:
                                      vibrantColor ?? theme.colorScheme.primary,
                                ),
                                itemSize: 18,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                animeDetails.score ?? '',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        InformationWidget(animeDetails: animeDetails),
                        DescriptionWidget(
                          animeDetails: animeDetails,
                          linkColor: vibrantColor,
                        ),
                        ScreenshotsWidget(animeDetails: animeDetails),
                        VideosWidget(animeDetails: animeDetails),
                        RolesWidget(roles: roles),
                        if (state.related.isNotEmpty)
                          RelatedWidget(relateds: state.related)
                        else
                          Container(),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CustomLoadingIndicator()),
        );
      },
    );
  }
}
