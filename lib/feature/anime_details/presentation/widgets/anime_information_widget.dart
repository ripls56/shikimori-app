part of '../view/anime_details.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({required this.animeDetails, super.key});

  final AnimeDetails animeDetails;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final titleTextStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withOpacity(.6),
    );

    final primaryTextStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w700,
    );

    const spacing = 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineWidget(
          title: 'Информация',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Wrap(
            runSpacing: spacing,
            spacing: spacing,
            children: [
              if (animeDetails.kind != null)
                InformationChip(
                  text: animeDetails.kind?.capitalize ?? '',
                  title: 'Тип',
                ),
              if (animeDetails.episodesAired != null)
                InformationChip(
                  text: '${animeDetails.episodesAired}'
                      ' из '
                      '${animeDetails.episodes}',
                  title: 'Эпизоды',
                ),
              if (animeDetails.duration != null)
                InformationChip(
                  text: animeDetails.duration.toString(),
                  title: 'Длительность эпизода',
                ),
              if (animeDetails.status != null)
                InformationChip(
                  text: animeDetails.status.toString().capitalize,
                  title: 'Статус',
                ),
              if (animeDetails.airedOn != null)
                InformationChip(
                  text:
                      '${animeDetails.airedOn?.add(const Duration(days: 7)).difference(DateTime.now()).inDays}'
                      ' дней',
                  title: 'До нового эпизода',
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class InformationChip extends StatelessWidget {
  const InformationChip({
    required this.text,
    required this.title,
    super.key,
  });

  final String text;

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final titleTextStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withOpacity(.6),
    );

    final primaryTextStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w700,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimension.borderRadius),
        border: Border.all(
          color: theme.colorScheme.onSurface,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleTextStyle,
            ),
            Text(
              text,
              style: primaryTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
