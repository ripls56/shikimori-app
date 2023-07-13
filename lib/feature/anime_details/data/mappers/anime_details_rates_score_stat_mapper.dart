import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_rates_score_stat_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_rates_score_stat.dart';

///[AnimeDetailsRatesScoresStat] mapper
extension AnimeDetailsRatesScoresStatMapper on AnimeDetailsRatesScoresStatDTO {
  ///Convert from model to entity
  AnimeDetailsRatesScoresStat toEntity() {
    return AnimeDetailsRatesScoresStat(
      name: name,
      value: value,
    );
  }
}
