part of '../view/anime_details.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    required this.animeDetails,
    super.key,
    this.linkColor,
  });

  final AnimeDetails animeDetails;

  final Color? linkColor;

  @override
  Widget build(BuildContext context) {
    if (animeDetails.description == null ||
        animeDetails.descriptionHtml == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        HeadlineWidget(
          title: 'Описание',
        ),
        if (animeDetails.descriptionHtml != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: HtmlDescriptionWidget(
              data: animeDetails.descriptionHtml,
              linkColor: linkColor,
            ),
          )
        else
          Text(animeDetails.description ?? ''),
      ],
    );
  }
}
