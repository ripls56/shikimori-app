import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/image/data/dto/image_dto.dart';

part 'character_seyu_dto.g.dart';

///Seyu data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class CharacterSeyuDTO {
  ///Constructor
  const CharacterSeyuDTO({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
  });

  factory CharacterSeyuDTO.fromJson(Map<String, dynamic> json) =>
      _$CharacterSeyuDTOFromJson(json);

  ///Seyu id
  final int id;

  ///Seyu name
  final String name;

  ///Seyu russian name
  final String russian;

  ///Seyu image
  final ImageDTO image;

  ///Seyu url
  final String url;
}
