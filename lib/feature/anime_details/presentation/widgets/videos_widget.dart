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
    if (animeDetails.videos.isEmpty) {
      return const SizedBox.shrink();
    }
    return HeadlineButton(
      onTap: () => _navigate(context),
      label: 'Видео',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SizedBox(
          height: 120,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: animeDetails.videos.length,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
                itemBuilder: (context, index) {
                  return ImageWidget(
                    width: constraints.maxWidth / 2,
                    url: animeDetails.videos[index]?.imageUrl ?? '',
                    fit: BoxFit.fitWidth,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
