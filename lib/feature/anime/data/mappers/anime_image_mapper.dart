import 'package:shikimoriapp/feature/anime/data/dto/anime_image_dto.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime_image.dart';

///Mapper for [AnimeImageDTO]
extension ImageMapper on AnimeImageDTO {
  ///Converts to [AnimeImage]
  AnimeImage toEntity() {
    return AnimeImage(
      original: original,
      preview: preview,
      x96: x96,
      x48: x48,
    );
  }
}
