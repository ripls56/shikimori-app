import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/anime/anime_card.dart';

class MangaLoadedWidget extends StatelessWidget {
  const MangaLoadedWidget(
      {super.key, required this.animes, required ScrollController controller})
      : _controller = controller;
  final ScrollController _controller;
  final List<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey<String>('page'),
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemExtent: 200,
      itemCount: animes.length,
      itemBuilder: ((context, index) {
        return AnimationConfiguration.staggeredList(
          delay: Duration.zero,
          position: index,
          child: ScaleAnimation(
            duration: const Duration(milliseconds: 500),
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 500),
              child: AnimeCardWidget(
                imageUrl: animes[index].image.preview,
                title: animes[index].name,
                score: animes[index].score,
                episodes: animes[index].episodes,
                animeId: animes[index].id,
              ),
            ),
          ),
        );
      }),
    );
  }
}
