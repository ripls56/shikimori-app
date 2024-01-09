import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_character_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_character.dart';
import 'package:shikimoriapp/feature/image/data/mapper/image_mapper.dart';

///[AnimeDetailsCharacter] mapper
extension AnimeDetailsCharacterMapper on AnimeDetailsCharacterDTO {
  ///Convert from model to entity
  AnimeDetailsCharacter toEntity() {
    return AnimeDetailsCharacter(
      id: id,
      name: name,
      russian: russian,
      image: image.toEntity(),
      url: url,
    );
  }
}
