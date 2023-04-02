part of '../../view/anime_details.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.animeDetails,
  });

  final anime_details.AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeadlineWidget(
          title: 'Описание',
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            animeDetails.description ?? '',
          ),
        ),
      ],
    );
  }
}
