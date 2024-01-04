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
    const blur = 8.0;
    final posterImageUrl = '${Env.shikimoriUrl}${animeDetails.image?.original}';

    final studioImageUrl =
        '${Env.shikimoriUrl}${animeDetails.studios.first?.image}';

    final theme = context.theme;

    return SizedBox(
      height: context.screenHeight * 0.3,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: ImageWidget(url: posterImageUrl),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blur,
                sigmaY: blur,
              ),
              child: const SizedBox.shrink(),
            ),
          ),

          // ImageWidget(
          //   url: posterImageUrl,
          //   width: MediaQuery.of(context).size.width / 2,
          // ),
        ],
      ),
    );
  }
}
