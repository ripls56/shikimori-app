import 'package:shikimoriapp/feature/anime/data/mappers/anime_mapper.dart';
import 'package:shikimoriapp/feature/character/data/dto/character_dto.dart';
import 'package:shikimoriapp/feature/character/data/mappers/character_seyu_mapper.dart';
import 'package:shikimoriapp/feature/character/domain/models/character.dart';
import 'package:shikimoriapp/feature/image/data/mapper/image_mapper.dart';

extension CharacterMapper on CharacterDTO {
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      russian: russian,
      image: image?.toEntity(),
      url: url,
      altName: altName,
      japanese: japanese,
      description: description,
      descriptionHtml: descriptionHtml,
      descriptionSource: descriptionSource,
      favoured: favoured,
      threadId: threadId,
      topicId: topicId,
      updatedAt: updatedAt,
      seyu: seyu.map((e) => e?.toEntity()).toList(),
      animes: animes.map((e) => e?.toEntity()).toList(),
      //mangas: mangas,
    );
  }
}
