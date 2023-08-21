import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shikimoriapp/common/widgets/anime_card.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Anime loaded widget
class AnimeLoadedWidget extends StatelessWidget {
  ///Default constructor
  const AnimeLoadedWidget({
    required this.animes,
    required ScrollController controller,
    super.key,
  }) : _controller = controller;
  final ScrollController _controller;

  ///List of animes
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
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          delay: Duration.zero,
          position: index,
          child: ScaleAnimation(
            duration: const Duration(milliseconds: 500),
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 500),
              child: AnimeCardWidget(
                imageUrl: animes[index].image?.preview ?? '',
                title: animes[index].name,
                score: animes[index].score ?? '',
                episodes: animes[index].episodes ?? 1,
                animeId: animes[index].id,
              ),
            ),
          ),
        );
      },
    );
  }
}
