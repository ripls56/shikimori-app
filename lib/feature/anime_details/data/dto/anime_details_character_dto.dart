import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/image/data/dto/image_dto.dart';

part 'anime_details_character_dto.g.dart';

///Anime character model
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsCharacterDTO {
  ///Constructor
  AnimeDetailsCharacterDTO(
    this.id,
    this.name,
    this.russian,
    this.image,
    this.url,
  );

  factory AnimeDetailsCharacterDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsCharacterDTOFromJson(json);

  ///Character id
  final int id;

  ///Character name
  final String name;

  ///Character russian name
  final String russian;

  ///Character image
  final ImageDTO image;

  ///Character url
  final String url;
}
