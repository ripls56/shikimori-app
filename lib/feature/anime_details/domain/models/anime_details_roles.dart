import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_character.dart';

///Anime roles model
class AnimeDetailsRoles {
  ///Constructor
  AnimeDetailsRoles({
    required this.roles,
    required this.rolesRussian,
    required this.character,
  });

  ///En roles
  final List<String> roles;

  ///Ru roles
  final List<String> rolesRussian;

  ///Character
  final AnimeDetailsCharacter? character;
}
