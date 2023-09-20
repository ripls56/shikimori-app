part of '../view/anime_details.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({required this.animeDetails, super.key});
  final AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    String buildGenresString(List<AnimeDetailsGenre?> genres) {
      var genresString = '';
      for (var i = 0; i < genres.length; i++) {
        i != 0
            ? genresString += ', ${genres[i]?.russian?.toLowerCase() ?? ''}'
            : genresString += genres[i]?.russian ?? '';
      }
      return genresString;
    }

    final titleTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withOpacity(.6),
    );

    final genresString = buildGenresString(animeDetails.genres);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineWidget(
          title: 'Информация',
        ),
        Padding(
          padding: const EdgeInsets.all(14),
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
                      animeDetails.kind?.capitalize ?? '',
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
                      animeDetails.status.toString().capitalize,
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
