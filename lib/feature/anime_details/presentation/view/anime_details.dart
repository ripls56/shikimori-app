import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/headline_button.dart';
import 'package:shikimoriapp/common/widgets/headline_widget.dart';
import 'package:shikimoriapp/common/widgets/html_description_widget.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/extension/string_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_genre.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/screenshots_page.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/videos_page.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/widgets/top/rating_diagram.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';

part '../widgets/anime_information_widget.dart';
part '../widgets/description.dart';
part '../widgets/related_widget.dart';
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
  @override
  void initState() {
    context.read<AnimeDetailCubit>().getAnimeDetails(widget._id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          return Scaffold(
            appBar: CustomAppBar(
              title: animeDetails.name ?? '',
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem<Text>(
                      child: Text('Add to list'),
                    ),
                  ],
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () =>
                  context.read<AnimeDetailCubit>().getAnimeDetails(widget._id),
              child: ListView(
                children: [
                  TopWidget(animeDetails: animeDetails),
                  InformationWidget(animeDetails: animeDetails),
                  if (animeDetails.description != null &&
                      animeDetails.descriptionHtml != null)
                    DescriptionWidget(animeDetails: animeDetails),
                  if (animeDetails.screenshots.isNotEmpty)
                    ScreenshotsWidget(animeDetails: animeDetails),
                  if (animeDetails.videos.isNotEmpty)
                    VideosWidget(animeDetails: animeDetails),
                  if (state.related.isNotEmpty)
                    RelatedWidget(relateds: state.related)
                  else
                    Container(),
                ],
              ),
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
