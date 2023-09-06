part of '../view/anime_details.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({required this.animeDetails, super.key});
  final AnimeDetails animeDetails;

  @Deprecated('Maybe remove later')
  Future<PaletteGenerator> _generator(String imgUrl) {
    return PaletteGenerator.fromImageProvider(Image.network(imgUrl).image);
  }

  double _findBigestScore() {
    var bigestScore = 0;
    for (var i = 0; i < animeDetails.ratesScoresStats.length; i++) {
      if (animeDetails.ratesScoresStats[i]?.value != null) {
        if (animeDetails.ratesScoresStats[i]!.value > bigestScore) {
          bigestScore = animeDetails.ratesScoresStats[i]!.value;
        }
      }
    }
    return bigestScore.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final posterImageUrl = '${Env.shikimoriUrl}${animeDetails.image?.original}';

    final studioImageUrl =
        '${Env.shikimoriUrl}${animeDetails.studios.first?.image}';

    final theme = context.theme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ColoredBox(
          color: theme.brightness != Brightness.dark
              ? Colors.black.withOpacity(.1)
              : Colors.white.withOpacity(.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ImageWidget(
              url: posterImageUrl,
              height: 300,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: theme.colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (animeDetails.studios.isNotEmpty)
                  Column(
                    children: [
                      HeadlineWidget(title: 'Студия'),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: CachedNetworkImage(
                          height: 60,
                          errorWidget: (context, url, error) {
                            return Center(
                              child: Image.asset(AppAssets.missing),
                            );
                          },
                          imageUrl: studioImageUrl,
                        ),
                      ),
                    ],
                  ),
                HeadlineWidget(
                  title: 'Рейтинг',
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBarIndicator(
                      unratedColor: theme.colorScheme.primary.withOpacity(.2),
                      rating: double.parse(animeDetails.score ?? '5') / 2,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: theme.colorScheme.primary,
                      ),
                      itemSize: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      animeDetails.score ?? '',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                AspectRatio(
                  aspectRatio: 1.18,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: BarChart(
                      BarChartData(
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBorder: const BorderSide(),
                            tooltipPadding: const EdgeInsets.all(8),
                            tooltipBgColor: theme.colorScheme.background,
                            getTooltipItem:
                                (group, groupIndex, rod, rodIndex) =>
                                    BarTooltipItem(
                              rod.toY.round().toString(),
                              theme.textTheme.bodyMedium!,
                            ),
                          ),
                        ),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(),
                          leftTitles: const AxisTitles(),
                          rightTitles: const AxisTitles(),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) => Text(
                                value.round().toString(),
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                        barGroups: animeDetails.ratesScoresStats
                            .map(
                              (e) => BarChartGroupData(
                                x: e?.name ?? -1,
                                barRods: [
                                  BarChartRodData(
                                    backDrawRodData: BackgroundBarChartRodData(
                                      show: true,
                                      toY: _findBigestScore(),
                                      color: theme.colorScheme.background,
                                    ),
                                    toY: e?.value.toDouble() ?? 0,
                                    color: theme.colorScheme.primary,
                                    width: 11,
                                    borderRadius: BorderRadius.zero,
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
