import 'package:shikimoriapp/feature/image/data/dto/image_dto.dart';
import 'package:shikimoriapp/feature/image/domain/model/image.dart';

///Mapper for [AnimeImageDTO]
extension ImageMapper on ImageDTO {
  ///Converts to [Image]
  Image toEntity() {
    return Image(
      original: original,
      preview: preview,
      x96: x96,
      x48: x48,
    );
  }
}
