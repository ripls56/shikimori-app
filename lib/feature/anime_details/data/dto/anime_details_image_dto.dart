import 'package:json_annotation/json_annotation.dart';

part 'anime_details_image_dto.g.dart';

///Image data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsImageDTO {
  ///Constructor
  const AnimeDetailsImageDTO({
    required this.original,
    required this.preview,
    required this.x96,
    required this.x48,
  });

  factory AnimeDetailsImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageDTOFromJson(json);

  ///Image original
  final String original;

  ///Image preview
  final String preview;

  ///Image size x96
  final String x96;

  ///Image size x48
  final String x48;
}
