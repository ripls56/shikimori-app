import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_roles_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_character_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_roles.dart';

///[AnimeDetailsRoles] mapper
extension AnimeDetailsCharacterapper on AnimeDetailsRolesDTO {
  ///Convert from model to entity
  AnimeDetailsRoles toEntity() {
    return AnimeDetailsRoles(
      roles: roles,
      rolesRussian: rolesRussian,
      character: character?.toEntity(),
    );
  }
}
