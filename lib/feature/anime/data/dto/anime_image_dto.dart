import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime_image.dart';

part 'anime_image_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)

///Data transfer object for [AnimeImage]
class AnimeImageDTO {
  ///Data transfer object for [AnimeImage]
  const AnimeImageDTO({
    required this.original,
    required this.preview,
    required this.x96,
    required this.x48,
  });

  ///Converts from json
  factory AnimeImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageDTOFromJson(json);

  ///Original image
  final String original;

  ///Preview image
  final String preview;

  ///Image with size 96x96
  final String x96;

  ///Image with size 48x48
  final String x48;
}
