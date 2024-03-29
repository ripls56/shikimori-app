part of '../view/anime_details.dart';

class VideosWidget extends StatelessWidget {
  const VideosWidget({
    required this.animeDetails,
    super.key,
  });

  final AnimeDetails animeDetails;

  void _navigate(BuildContext context) {
    if (animeDetails.id == null) {
      return;
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideosPage(
            id: animeDetails.id!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeadlineButton(
      onPress: () => _navigate(context),
      title: 'Видео',
      child: SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Align(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: animeDetails.videos.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
                  ),
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ImageWidget(
                        url: animeDetails.videos[index]?.imageUrl ?? '',
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  },
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => _navigate(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
