import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_rates_score_stat.dart';

class RatingDiagram extends StatelessWidget {
  const RatingDiagram({Key? key, required this.stats}) : super(key: key);

  final List<AnimeDetailsRatesScoresStat?> stats;

  @override
  Widget build(BuildContext context) {
    double findBigestScore() {
      var bigestScore = 0;
      for (var i = 0; i < stats.length; i++) {
        if (stats[i]?.value != null) {
          if (stats[i]!.value > bigestScore) {
            bigestScore = stats[i]!.value;
          }
        }
      }
      return bigestScore.toDouble();
    }

    final theme = context.theme;
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBorder: const BorderSide(),
            tooltipPadding: const EdgeInsets.all(8),
            tooltipBgColor: theme.colorScheme.background,
            getTooltipItem: (group, groupIndex, rod, rodIndex) =>
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
        barGroups: stats
            .map(
              (e) => BarChartGroupData(
                x: e?.name ?? -1,
                barRods: [
                  BarChartRodData(
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: findBigestScore(),
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
    );
  }
}
