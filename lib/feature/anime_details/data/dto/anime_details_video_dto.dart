import 'package:json_annotation/json_annotation.dart';

part 'anime_details_video_dto.g.dart';

///Video data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsVideoDTO {
  ///Constructor
  const AnimeDetailsVideoDTO({
    required this.id,
    required this.url,
    required this.imageUrl,
    required this.playerUrl,
    required this.name,
    required this.kind,
    required this.hosting,
  });

  factory AnimeDetailsVideoDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsVideoDTOFromJson(json);

  ///Video id
  final int id;

  ///Video url
  final String url;

  ///Video image url
  final String imageUrl;

  ///Video player url
  final String playerUrl;

  ///Video name
  final String name;

  ///Video kind
  final String kind;

  ///Video hosting
  final String hosting;
}
