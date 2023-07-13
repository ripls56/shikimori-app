part of '../view/anime_details.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({required this.animeDetails, super.key});
  final AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    String buildGenresString(List<AnimeDetailsGenre?> genres) {
      var genresString = '';
      for (var i = 0; i < genres.length; i++) {
        i != 0
            ? genresString += ', ${genres[i]?.russian ?? ''}'
            : genresString += genres[i]?.russian ?? '';
      }
      return genresString;
    }

    final genresString = buildGenresString(animeDetails.genres);

    final titleTextStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
        );

    final mainTextStyle = Theme.of(context).textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineWidget(
          title: 'Информация',
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Тип: ',
                    style: titleTextStyle,
                  ),
                  Flexible(
                    child: Text(
                      animeDetails.kind ?? '',
                      style: mainTextStyle,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Эпизоды: ',
                    style: titleTextStyle,
                  ),
                  Flexible(
                    child: Text(
                      animeDetails.episodes.toString(),
                      style: mainTextStyle,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Длительность эпизода: ',
                    style: titleTextStyle,
                  ),
                  Flexible(
                    child: Text(
                      animeDetails.duration.toString(),
                      style: mainTextStyle,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Статус: ',
                    style: titleTextStyle,
                  ),
                  Flexible(
                    child: Text(
                      animeDetails.status.toString(),
                      style: mainTextStyle,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Жанры: ',
                    style: titleTextStyle,
                  ),
                  Flexible(
                    child: Text(
                      genresString,
                      textAlign: TextAlign.center,
                      style: mainTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
