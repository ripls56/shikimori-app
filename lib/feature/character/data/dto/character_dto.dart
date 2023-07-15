import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime/data/dto/anime_dto.dart';
import 'package:shikimoriapp/feature/character/data/dto/character_seyu_dto.dart';
import 'package:shikimoriapp/feature/image/data/dto/image_dto.dart';

part 'character_dto.g.dart';

///Character data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class CharacterDTO {
  ///Constructor
  const CharacterDTO({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.altName,
    required this.japanese,
    required this.description,
    required this.descriptionHtml,
    required this.descriptionSource,
    required this.favoured,
    required this.threadId,
    required this.topicId,
    required this.updatedAt,
    required this.seyu,
    required this.animes,
    //required this.mangas,
  });

  factory CharacterDTO.fromJson(Map<String, dynamic> json) =>
      _$CharacterDTOFromJson(json);

  ///Character id
  final int? id;

  ///Character name
  final String? name;

  ///Character russian name
  final String? russian;

  ///Character image
  final ImageDTO? image;

  ///Character url
  final String? url;

  ///Character alternative name
  final dynamic altName;

  ///Character japanese name
  final String? japanese;

  ///Character description
  final dynamic description;

  ///Character description html
  final String? descriptionHtml;

  ///Character description source
  final dynamic descriptionSource;

  ///Character favoured
  final bool? favoured;

  ///Character thread id
  final int? threadId;

  ///Character topic id
  final int? topicId;

  ///Character updated at
  final DateTime? updatedAt;

  ///Character seyu
  final List<CharacterSeyuDTO?> seyu;

  ///Character animes
  final List<AnimeDTO?> animes;

  ///Character mangas
  //final List<MangaD>? mangas;
}
