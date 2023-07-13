import 'package:json_annotation/json_annotation.dart';

part 'anime_details_screenshot_dto.g.dart';

///Screenshot data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsScreenshotDTO {
  ///Constructor
  const AnimeDetailsScreenshotDTO({
    required this.original,
    required this.preview,
  });

  factory AnimeDetailsScreenshotDTO.fromJson(Map<String, dynamic> json) =>
      _$ScreenshotDTOFromJson(json);

  ///Screenshot original
  final String original;

  ///Screenshot preview
  final String preview;
}
