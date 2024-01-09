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
        MaterialPageRoute<void>(
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
    if (animeDetails.screenshots.isEmpty) {
      return const SizedBox.shrink();
    }
    return HeadlineButton(
      onTap: () => _navigate(context),
      label: 'Кадры',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              height: 120,
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
          ),
        ],
      ),
    );
  }
}
