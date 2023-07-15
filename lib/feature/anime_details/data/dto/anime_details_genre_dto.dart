import 'package:json_annotation/json_annotation.dart';

part 'anime_details_genre_dto.g.dart';

///Genre data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsGenreDTO {
  ///Constructor
  const AnimeDetailsGenreDTO({
    required this.id,
    required this.name,
    required this.russian,
    required this.kind,
  });

  factory AnimeDetailsGenreDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsGenreDTOFromJson(json);

  ///Genre id
  final int? id;

  ///Genre name
  final String? name;

  ///Genre russian name
  final String? russian;

  ///Genre kind
  final String? kind;
}
