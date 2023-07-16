part of '../view/anime_details.dart';

class RelatedWidget extends StatelessWidget {
  const RelatedWidget({required this.relateds, super.key});

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
              return _AnimeCard(
                anime: relateds[index].anime!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AnimeCard extends StatelessWidget {
  const _AnimeCard({required this.anime});
  final Anime anime;

  @override
  Widget build(BuildContext context) {
    debugPrint('${Env.host}${anime.image?.preview}');
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AnimeDetailScreen(id: anime.id),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            height: 226,
            imageUrl: '${Env.host}${anime.image?.original}',
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

// class _MangaCard extends StatelessWidget {
//   const _MangaCard({required this.manga});
//   final Manga manga;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: HapticFeedback.lightImpact,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CachedNetworkImage(
//             height: 226,
//             imageUrl: '${Env.host}${manga.image?.original}',
//             errorWidget: (context, url, error) {
//               return Center(
//                 child: Image.asset(AppImages.missing),
//               );
//             },
//             fit: BoxFit.fitHeight,
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           Flexible(
//             child: Text(
//               manga.name ?? '',
//               style: Theme.of(context).textTheme.titleSmall,
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
