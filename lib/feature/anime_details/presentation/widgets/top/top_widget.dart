part of '../../view/anime_details.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({required this.animeDetails, super.key});
  final AnimeDetails animeDetails;

  @Deprecated('Maybe remove later')
  Future<PaletteGenerator> _generator(String imgUrl) {
    return PaletteGenerator.fromImageProvider(Image.network(imgUrl).image);
  }

  @override
  Widget build(BuildContext context) {
    final posterImageUrl = '${Env.shikimoriUrl}${animeDetails.image?.original}';

    final studioImageUrl =
        '${Env.shikimoriUrl}${animeDetails.studios.first?.image}';

    final theme = context.theme;

    return SizedBox(
      height: 290,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            url: posterImageUrl,
            width: MediaQuery.of(context).size.width / 2,
          ),
          Expanded(
            child: ColoredBox(
              color: theme.colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (animeDetails.studios.isNotEmpty)
                    Column(
                      children: [
                        HeadlineWidget(title: 'Студия'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ImageWidget(
                            height: 46,
                            url: studioImageUrl,
                          ),
                        ),
                      ],
                    ),
                  HeadlineWidget(
                    title: 'Рейтинг',
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RatingBarIndicator(
                              unratedColor:
                                  theme.colorScheme.primary.withOpacity(.25),
                              rating:
                                  double.parse(animeDetails.score ?? '5') / 2,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: theme.colorScheme.primary,
                              ),
                              itemSize: 24,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              animeDetails.score ?? '',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        AspectRatio(
                          aspectRatio:
                              (MediaQuery.of(context).size.width / 2) / 100,
                          child: RatingDiagram(
                            stats: animeDetails.ratesScoresStats,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
