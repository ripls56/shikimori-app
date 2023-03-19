import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnimeDetailCubit, AnimeDetailState>(
        builder: (context, state) {
          if (state is AnimeDetailLoaded) {
            var animeDetails = state.animeDetails;
            var genresString = "";
            for (var i = 0; i < animeDetails.genres.length; i++) {
              i != 0
                  ? genresString += ', ${animeDetails.genres[i].russian}'
                  : genresString += animeDetails.genres[i].russian;
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(animeDetails.name),
              ),
              body: RefreshIndicator(
                onRefresh: () =>
                    context.read<AnimeDetailCubit>().getAnimeDetails(widget.id),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width / 2,
                            imageUrl:
                                '$SHIKIMORI_URL${animeDetails.image.original}',
                          ),
                        ),
                        Expanded(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const HeadlineWidget(title: 'Студия', height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating:
                                        double.parse(animeDetails.score) / 2,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.blue.shade300,
                                    ),
                                    itemCount: 5,
                                    itemSize: 24.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    animeDetails.score,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                    HeadlineButton(
                      onPress: () => debugPrint('pressed'),
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
                    ),
                    HeadlineButton(
                      onPress: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideosPage(
                            id: state.animeDetails.id,
                          ),
                        ),
                      ),
                      title: 'Видео',
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
                                        animeDetails.videos[index].imageUrl,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
