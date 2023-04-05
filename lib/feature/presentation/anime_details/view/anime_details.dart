import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart'
    as anime_details;
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/screenshots_page.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/videos_page.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/widgets/headline_button.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/widgets/headline_widget.dart';
import 'package:shikimoriapp/feature/presentation/widgets/custom_loading_bar.dart';

part '../widgets/details/top_widget.dart';
part '../widgets/details/anime_information_widget.dart';
part '../widgets/details/description.dart';
part '../widgets/details/screenshot_widget.dart';
part '../widgets/details/videos_widget.dart';
part '../widgets/details/related_widget.dart';

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
    return Scaffold(
      body: BlocBuilder<AnimeDetailCubit, AnimeDetailState>(
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
          return const CustomLoadingBar();
        },
      ),
    );
  }
}
