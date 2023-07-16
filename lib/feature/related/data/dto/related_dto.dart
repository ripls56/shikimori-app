import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime/data/dto/anime_dto.dart';

part 'related_dto.g.dart';

///Related model
@JsonSerializable(fieldRename: FieldRename.snake)
class RelatedDTO {
  ///Constructor
  const RelatedDTO({
    this.relation,
    this.relationRussian,
    this.anime,
    //this.manga,
  });

  factory RelatedDTO.fromJson(Map<String, dynamic> json) =>
      _$RelatedDTOFromJson(json);

  ///Relation
  final String? relation;

  ///Relation russian
  final String? relationRussian;

  ///Anime
  final AnimeDTO? anime;

  //final Manga? manga;
}
