part of '../view/anime_details.dart';

class TopWidget extends StatelessWidget {
  final anime_details.AnimeDetails animeDetails;

  const TopWidget({super.key, required this.animeDetails});

  @override
  Widget build(context) {
    Future<PaletteGenerator> generator(String imgUrl) {
      return PaletteGenerator.fromImageProvider(Image.network(imgUrl).image);
    }

    double findBigestScore() {
      double bigestScore = 0;
      for (var i = 0; i < animeDetails.ratesScoresStats.length; i++) {
        if (animeDetails.ratesScoresStats[i]?.value != null) {
          if (animeDetails.ratesScoresStats[i]!.value > bigestScore) {
            bigestScore = animeDetails.ratesScoresStats[i]!.value.toDouble();
          }
        }
      }
      return bigestScore;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: generator('${Env.host}${animeDetails.image?.original}'),
          builder: (context, snapshot) {
            return Container(
              color: snapshot.data?.darkMutedColor?.color ??
                  Theme.of(context).colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2,
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Image.asset(AppImages.missing),
                    );
                  },
                  imageUrl: '${Env.host}${animeDetails.image?.original}',
                ),
              ),
            );
          },
        ),
        Expanded(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (animeDetails.studios.isNotEmpty)
                  Column(
                    children: [
                      HeadlineWidget(title: 'Студия'),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CachedNetworkImage(
                            height: 60,
                            errorWidget: (context, url, error) {
                              return Center(
                                child: Image.asset(AppImages.missing),
                              );
                            },
                            imageUrl:
                                '${Env.host}${animeDetails.studios.first?.image}'),
                      ),
                    ],
                  ),
                HeadlineWidget(
                  title: 'Рейтинг',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: generator(
                          '${Env.host}${animeDetails.image?.original}'),
                      builder: (context, snapshot) => RatingBarIndicator(
                        unratedColor: snapshot.data?.lightMutedColor?.color ??
                            Theme.of(context).colorScheme.background,
                        rating: double.parse(animeDetails.score ?? '5') / 2,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: snapshot.data?.darkMutedColor?.color ??
                              Theme.of(context).colorScheme.onBackground,
                        ),
                        itemCount: 5,
                        itemSize: 24.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      animeDetails.score ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                FutureBuilder(
                  future:
                      generator('${Env.host}${animeDetails.image?.original}'),
                  builder: (context, snapshot) {
                    return AspectRatio(
                      aspectRatio: 1.18,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BarChart(
                          BarChartData(
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipPadding: const EdgeInsets.all(8),
                                tooltipBgColor:
                                    Theme.of(context).colorScheme.onBackground,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) =>
                                        BarTooltipItem(
                                  rod.toY.round().toString(),
                                  Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                ),
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) => Text(
                                    value.round().toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                        backDrawRodData:
                                            BackgroundBarChartRodData(
                                          show: true,
                                          toY: findBigestScore(),
                                          color: snapshot.data?.lightMutedColor
                                                  ?.color ??
                                              Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                        ),
                                        toY: e?.value.toDouble() ?? 0,
                                        color: snapshot
                                                .data?.darkMutedColor?.color ??
                                            Theme.of(context)
                                                .colorScheme
                                                .onBackground,
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
