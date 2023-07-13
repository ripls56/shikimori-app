part of '../view/anime_details.dart';

class VideosButton extends StatelessWidget {
  const VideosButton({
    required this.animeDetails,
    super.key,
  });

  final AnimeDetails animeDetails;

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
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: animeDetails.videos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Image.asset(AppImages.missing),
                          );
                        },
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
