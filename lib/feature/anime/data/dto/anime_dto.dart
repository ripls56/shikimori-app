import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime/data/dto/anime_image_dto.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

part 'anime_dto.g.dart';

///Data transfer object for [Anime]
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDTO {
  ///Data transfer object for [Anime]
  AnimeDTO(
    this.id,
    this.name,
    this.russian,
    this.image,
    this.url,
    this.kind,
    this.score,
    this.status,
    this.episodes,
    this.episodesAired,
    this.airedOn,
    this.releasedOn,
  );

  ///Converts from json
  factory AnimeDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDTOFromJson(json);

  ///Anime id
  final int id;

  ///Anime name
  final String name;

  ///Anime russian name
  final String? russian;

  ///Anime image
  final AnimeImageDTO? image;

  ///Anime url
  final String? url;

  ///Anime kind
  final String? kind;

  ///Anime score
  final String? score;

  ///Anime status
  final String? status;

  ///Anime episodes
  final int? episodes;

  ///Anime episodes aired
  final int? episodesAired;

  ///Anime aired on
  final DateTime? airedOn;

  ///Anime released on
  final DateTime? releasedOn;
}
