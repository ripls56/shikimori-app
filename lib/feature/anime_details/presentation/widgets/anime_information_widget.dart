part of '../view/anime_details.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({required this.animeDetails, super.key});
  final AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final titleTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withOpacity(.6),
    );

    final primaryTextStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
    );

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
                      style: primaryTextStyle,
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
                      style: primaryTextStyle,
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
                      style: primaryTextStyle,
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
                      style: primaryTextStyle,
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
