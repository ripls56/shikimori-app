import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_studio_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_studio.dart';

///[AnimeDetailsStudio] mapper
extension AnimeDetailsStudioMapper on AnimeDetailsStudioDTO {
  ///Convert from model to entity
  AnimeDetailsStudio toEntity() {
    return AnimeDetailsStudio(
      id: id,
      name: name,
      filteredName: filteredName,
      real: real,
      image: image,
    );
  }
}
