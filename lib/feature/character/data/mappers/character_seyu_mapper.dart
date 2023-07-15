import 'package:shikimoriapp/feature/character/data/dto/character_seyu_dto.dart';
import 'package:shikimoriapp/feature/character/domain/models/character_seyu.dart';
import 'package:shikimoriapp/feature/image/data/mapper/image_mapper.dart';

///[CharacterSeyu] mapper
extension CharacterSeyuMapper on CharacterSeyuDTO {
  CharacterSeyu toEntity() {
    return CharacterSeyu(
      id: id,
      name: name,
      russian: russian,
      image: image.toEntity(),
      url: url,
    );
  }
}
