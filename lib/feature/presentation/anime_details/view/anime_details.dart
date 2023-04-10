import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/core/widgets/headline_button.dart';
import 'package:shikimoriapp/core/widgets/headline_widget.dart';
import 'package:shikimoriapp/core/widgets/html_description_widget.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart'
    as anime_details;
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/screenshots_page.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/videos_page.dart';
import 'package:shikimoriapp/core/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/feature/presentation/character_screen/view/character_screen.dart';
import 'package:url_launcher/url_launcher.dart';

part '../widgets/top_widget.dart';
part '../widgets/anime_information_widget.dart';
part '../widgets/description.dart';
part '../widgets/screenshot_widget.dart';
part '../widgets/videos_widget.dart';
part '../widgets/related_widget.dart';

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  void initState() {
    context.read<AnimeDetailCubit>().getAnimeDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimeDetailCubit, AnimeDetailState>(
      listener: (context, state) {
        if (state is AnimeDetailError) {
          Future.delayed(
            const Duration(seconds: 5),
            () => context.read<AnimeDetailCubit>().getAnimeDetails(widget.id),
          );
        }
      },
      builder: (context, state) {
        if (state is AnimeDetailLoaded) {
          anime_details.AnimeDetails animeDetails = state.animeDetails;
          return Scaffold(
            appBar: AppBar(
              title: Text(animeDetails.name ?? ''),
            ),
            body: RefreshIndicator(
              onRefresh: () =>
                  context.read<AnimeDetailCubit>().getAnimeDetails(widget.id),
              child: ListView(
                children: [
                  TopWidget(animeDetails: animeDetails),
                  InformationWidget(animeDetails: animeDetails),
                  DescriptionWidget(animeDetails: animeDetails),
                  animeDetails.screenshots.isNotEmpty
                      ? ScreenshotsWidget(animeDetails: animeDetails)
                      : Container(),
                  animeDetails.videos.isNotEmpty
                      ? VideosButton(animeDetails: animeDetails)
                      : Container(),
                  state.related.isNotEmpty
                      ? RelatedWidget(relateds: state.related)
                      : Container(),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CustomLoadingBar()),
        );
      },
    );
  }
}
