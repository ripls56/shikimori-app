part of '../view/anime_details.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    required this.animeDetails,
    super.key,
  });

  final AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineWidget(
          title: 'Описание',
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: HtmlDescriptionWidget(data: animeDetails.descriptionHtml),
        ),
      ],
    );
  }
}
