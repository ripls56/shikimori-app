import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_rates_statuses_stat_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_rates_score_stat.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_rates_statuses_stat.dart';

///[AnimeDetailsRatesScoresStat] mapper
extension AnimeDetailsRatesStatusesStatMapper
    on AnimeDetailsRatesStatusesStatDTO {
  ///Convert from model to entity
  AnimeDetailsRatesStatusesStat toEntity() {
    return AnimeDetailsRatesStatusesStat(
      name: name,
      value: value,
    );
  }
}
