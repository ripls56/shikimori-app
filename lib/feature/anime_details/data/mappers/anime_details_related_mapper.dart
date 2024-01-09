import 'package:shikimoriapp/feature/anime/data/mappers/anime_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_related_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_related.dart';

///[AnimeDetailsRelated] mapper
extension AnimeDetailsRelatedMapper on AnimeDetailsRelatedDTO {
  ///Convert [AnimeDetailsRelatedDTO] in [AnimeDetailsRelated]
  AnimeDetailsRelated toEntity() {
    return AnimeDetailsRelated(
      relation: relation,
      relationRussian: relationRussian,
      anime: anime?.toEntity(),
    );
  }
}
