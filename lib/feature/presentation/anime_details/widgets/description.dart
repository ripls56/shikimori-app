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
          child: Html(
            style: {
              'div': Style(textAlign: TextAlign.justify),
            },
            onLinkTap: (url, rcontext, attributes, element) {
              Map<String, dynamic> data = jsonDecode(attributes['data-attrs']!);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CharacterScreen(id: data['id']),
                ),
              );
            },
            data: animeDetails.descriptionHtml,
          ),
        ),
      ],
    );
  }
}
