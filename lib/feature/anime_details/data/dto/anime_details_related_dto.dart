import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime/data/dto/anime_dto.dart';

part 'anime_details_related_dto.g.dart';

///Related model
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsRelatedDTO {
  ///Constructor
  const AnimeDetailsRelatedDTO({
    this.relation,
    this.relationRussian,
    this.anime,
  });

  factory AnimeDetailsRelatedDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsRelatedDTOFromJson(json);

  ///Relation
  final String? relation;

  ///Relation russian
  final String? relationRussian;

  ///Anime
  final AnimeDTO? anime;
}
