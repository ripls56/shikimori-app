import 'package:shikimoriapp/feature/anime/data/mappers/anime_mapper.dart';
import 'package:shikimoriapp/feature/related/data/dto/related_dto.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';

///[Related] mapper
extension RelatedMapper on RelatedDTO {
  ///Convert [RelatedDTO] in [Related]
  Related toEntity() {
    return Related(
      relation: relation,
      relationRussian: relationRussian,
      anime: anime?.toEntity(),
    );
  }
}
