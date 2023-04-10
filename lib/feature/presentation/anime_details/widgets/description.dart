part of '../view/anime_details.dart';

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
        HeadlineWidget(
          title: 'Описание',
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlDescriptionWidget(data: animeDetails.descriptionHtml),
        ),
      ],
    );
  }
}
