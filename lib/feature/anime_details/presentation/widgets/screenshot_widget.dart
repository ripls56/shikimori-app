part of '../view/anime_details.dart';

class ScreenshotsWidget extends StatelessWidget {
  const ScreenshotsWidget({
    required this.animeDetails,
    super.key,
  });

  final AnimeDetails animeDetails;

  String _screenshotUrl(int index) =>
      '${Env.shikimoriUrl}${animeDetails.screenshots[index]!.original}';

  @override
  Widget build(BuildContext context) {
    return HeadlineButton(
      onPress: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScreenshotsPage(
            id: animeDetails.id ?? 1,
          ),
        ),
      ),
      title: 'Кадры',
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
                      child: ImageWidget(
                        url: _screenshotUrl(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: GestureDetector(onTap: () {
                if (animeDetails.id == null) {
                  return;
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScreenshotsPage(
                        id: animeDetails.id!,
                      ),
                    ),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

// HeadlineButton(
//       onPress: () => Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => ScreenshotsPage(
//           id: animeDetails.id ?? 1,
//         ),
//       )),
//       title: 'Кадры',
//       height: 30,
//       child: SizedBox(
//         height: 110,
//         width: MediaQuery.of(context).size.width,
//         child: Align(
//           alignment: Alignment.center,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: animeDetails.screenshots.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: CachedNetworkImage(
//                     fit: BoxFit.fitWidth,
//                     imageUrl:
//                         '$SHIKIMORI_URL${animeDetails.screenshots[index]!.original}',
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
