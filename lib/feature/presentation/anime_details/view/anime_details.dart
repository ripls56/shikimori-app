import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart'
    as anime_details;
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/screenshots_page.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/videos_page.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/widgets/headline_button.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/widgets/headline_widget.dart';

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

  Future<PaletteGenerator> _generator(String imgUrl) {
    return PaletteGenerator.fromImageProvider(Image.network(imgUrl).image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnimeDetailCubit, AnimeDetailState>(
        builder: (context, state) {
          if (state is AnimeDetailLoaded) {
            anime_details.AnimeDetails animeDetails = state.animeDetails;
            var children2 = [
              Row(
                children: [
                  FutureBuilder(
                    future: _generator(
                        '$SHIKIMORI_URL${animeDetails.image.original}'),
                    builder: (context, snapshot) {
                      return Container(
                        color: snapshot.data?.dominantColor?.color ??
                            Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width / 2,
                            errorWidget: (context, url, error) => const Center(
                                child: Text('Картинка отсутсвует')),
                            imageUrl:
                                '$SHIKIMORI_URL${animeDetails.image.original}',
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const HeadlineWidget(title: 'Студия', height: 30),
                        CachedNetworkImage(
                            errorWidget: (context, url, error) => const Center(
                                child: Text('Картинка отсутсвует')),
                            imageUrl:
                                '$SHIKIMORI_URL${animeDetails.studios.first.image}'),
                        const HeadlineWidget(title: 'Рейтинг', height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: _generator(
                                  '$SHIKIMORI_URL${animeDetails.image.original}'),
                              builder: (context, snapshot) =>
                                  RatingBarIndicator(
                                unratedColor:
                                    snapshot.data?.lightMutedColor?.color ??
                                        Colors.grey.shade700,
                                rating: double.parse(animeDetails.score) / 2,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: snapshot.data?.dominantColor?.color ??
                                      Colors.transparent,
                                ),
                                itemCount: 5,
                                itemSize: 24.0,
                                direction: Axis.horizontal,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              animeDetails.score,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InformationWidget(animeDetails: animeDetails),
              DescriptionWidget(animeDetails: animeDetails),
              ScreenshotsButton(animeDetails: animeDetails),
              VideosButton(animeDetails: animeDetails),
            ];
            return Scaffold(
              appBar: AppBar(
                title: Text(animeDetails.name),
              ),
              body: RefreshIndicator(
                onRefresh: () =>
                    context.read<AnimeDetailCubit>().getAnimeDetails(widget.id),
                child: ListView(
                  children: children2,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  final anime_details.AnimeDetails animeDetails;
  const InformationWidget({Key? key, required this.animeDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String buildGenresString(List<anime_details.Genre> genres) {
      String genresString = '';
      for (var i = 0; i < genres.length; i++) {
        i != 0
            ? genresString += ', ${genres[i].russian}'
            : genresString += genres[i].russian;
      }
      return genresString;
    }

    var genresString = buildGenresString(animeDetails.genres);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadlineWidget(
          title: 'Информация',
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Тип: ${animeDetails.kind}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Эпизоды: ${animeDetails.episodes}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Длительность эпизода: ${animeDetails.duration} мин.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Статус: ${animeDetails.status}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Жанры: $genresString',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.animeDetails,
  });

  final anime_details.AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeadlineWidget(
          title: 'Описание',
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            animeDetails.description,
          ),
        ),
      ],
    );
  }
}

class ScreenshotsButton extends StatelessWidget {
  const ScreenshotsButton({
    super.key,
    required this.animeDetails,
  });

  final anime_details.AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    return HeadlineButton(
      onPress: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScreenshotsPage(
          id: animeDetails.id,
        ),
      )),
      title: 'Кадры',
      height: 30,
      child: SizedBox(
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: animeDetails.videos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl:
                        '$SHIKIMORI_URL${animeDetails.screenshots[index].original}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class VideosButton extends StatelessWidget {
  const VideosButton({
    super.key,
    required this.animeDetails,
  });

  final anime_details.AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    return HeadlineButton(
      onPress: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideosPage(
            id: animeDetails.id,
          ),
        ),
      ),
      title: 'Видео',
      height: 30,
      child: SizedBox(
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: animeDetails.videos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: animeDetails.videos[index].imageUrl,
                      ),
                    ),
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideosPage(
                      id: animeDetails.id,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
