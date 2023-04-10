part of '../view/anime_details.dart';

class RelatedWidget extends StatelessWidget {
  const RelatedWidget({super.key, required this.relateds});

  final List<Related> relateds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineWidget(
          title: 'Похожие',
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            itemExtent: MediaQuery.of(context).size.width / 2,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: relateds.length,
            itemBuilder: (context, index) {
              return relateds[index].anime != null
                  ? _AnimeCard(
                      anime: relateds[index].anime!,
                    )
                  : _MangaCard(
                      manga: relateds[index].manga!,
                    );
            },
          ),
        ),
      ],
    );
  }
}

class _AnimeCard extends StatelessWidget {
  final Anime anime;
  const _AnimeCard({required this.anime});

  @override
  Widget build(BuildContext context) {
    debugPrint('$SHIKIMORI_URL${anime.image?.preview}');
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AnimeDetailScreen(id: anime.id)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            height: 226,
            imageUrl: '$SHIKIMORI_URL${anime.image?.original}',
            errorWidget: (context, url, error) {
              return Center(
                child: Image.asset(AppImages.missing),
              );
            },
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            height: 6,
          ),
          Flexible(
            child: Text(
              anime.name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}

class _MangaCard extends StatelessWidget {
  final Manga manga;
  const _MangaCard({required this.manga});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (context) => AnimeDetailScreen(id: manga.id ?? 1)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            height: 226,
            imageUrl: '$SHIKIMORI_URL${manga.image?.original}',
            errorWidget: (context, url, error) {
              return Center(
                child: Image.asset(AppImages.missing),
              );
            },
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            height: 6,
          ),
          Flexible(
            child: Text(
              manga.name ?? '',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
