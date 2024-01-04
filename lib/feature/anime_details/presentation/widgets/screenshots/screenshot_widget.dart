part of '../../view/anime_details.dart';

class ScreenshotsWidget extends StatelessWidget {
  const ScreenshotsWidget({
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
          builder: (context) => ScreenshotsPage(
            id: animeDetails.id!,
          ),
        ),
      );
    }
  }

  String _screenshotUrl(int index) =>
      '${Env.shikimoriUrl}${animeDetails.screenshots[index]!.original}';

  @override
  Widget build(BuildContext context) {
    return HeadlineButton(
      onTap: () => _navigate(context),
      title: 'Кадры',
      child: SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: animeDetails.screenshots.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    itemBuilder: (context, index) {
                      return ImageWidget(
                        width: constraints.maxWidth / 2,
                        url: '${Env.shikimoriUrl}'
                            '${animeDetails.screenshots[index]?.original}',
                        fit: BoxFit.fitWidth,
                      );
                    },
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => _navigate(context),
              ),
            ),
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
