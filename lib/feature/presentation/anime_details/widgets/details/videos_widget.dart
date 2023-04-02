part of '../../view/anime_details.dart';

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
            id: animeDetails.id ?? 1,
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
                        imageUrl: animeDetails.videos[index]?.imageUrl ?? '',
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
                      id: animeDetails.id ?? 1,
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
