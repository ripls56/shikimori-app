import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_character_dto.dart';

part 'anime_details_roles_dto.g.dart';

///Anime roles model
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsRolesDTO {
  ///Constructor
  AnimeDetailsRolesDTO(
    this.roles,
    this.rolesRussian,
    this.character,
  );

  factory AnimeDetailsRolesDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsRolesDTOFromJson(json);

  ///En roles
  final List<String> roles;

  ///Ru roles
  final List<String> rolesRussian;

  ///Character
  final AnimeDetailsCharacterDTO? character;
}
