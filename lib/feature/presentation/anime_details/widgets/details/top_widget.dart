part of '../../view/anime_details.dart';

class TopWidget extends StatelessWidget {
  final anime_details.AnimeDetails animeDetails;

  const TopWidget({super.key, required this.animeDetails});

  @override
  Widget build(context) {
    Future<PaletteGenerator> generator(String imgUrl) {
      return PaletteGenerator.fromImageProvider(Image.network(imgUrl).image);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: generator('$SHIKIMORI_URL${animeDetails.image?.original}'),
          builder: (context, snapshot) {
            return Container(
              color: snapshot.data?.dominantColor?.color ?? Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width / 2,
                  errorWidget: (context, url, error) => const Center(
                    child: Text('Картинка отсутсвует'),
                  ),
                  imageUrl: '$SHIKIMORI_URL${animeDetails.image?.original}',
                ),
              ),
            );
          },
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (animeDetails.studios.isNotEmpty)
                Column(
                  children: [
                    const HeadlineWidget(title: 'Студия', height: 30),
                    CachedNetworkImage(
                        errorWidget: (context, url, error) => const Center(
                              child: Text('Картинка отсутсвует'),
                            ),
                        imageUrl:
                            '$SHIKIMORI_URL${animeDetails.studios.first?.image}'),
                  ],
                ),
              const HeadlineWidget(title: 'Рейтинг', height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: generator(
                        '$SHIKIMORI_URL${animeDetails.image?.original}'),
                    builder: (context, snapshot) => RatingBarIndicator(
                      unratedColor: snapshot.data?.lightMutedColor?.color ??
                          Colors.grey.shade700,
                      rating: double.parse(animeDetails.score ?? '5') / 2,
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
                    animeDetails.score ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
