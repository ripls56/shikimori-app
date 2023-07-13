import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_image_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_image.dart';

///[AnimeDetailsImage] mapper
extension AnimeDetailsImageMapper on AnimeDetailsImageDTO {
  ///Convert from model to entity
  AnimeDetailsImage toEntity() {
    return AnimeDetailsImage(
      original: original,
      preview: preview,
      x96: x96,
      x48: x48,
    );
  }
}
