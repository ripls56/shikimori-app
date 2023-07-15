import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/image/domain/model/image.dart';

part 'image_dto.g.dart';

///Data transfer object for [Image]
@JsonSerializable(fieldRename: FieldRename.snake)
class ImageDTO {
  ///Data transfer object for [Image]
  const ImageDTO({
    required this.original,
    required this.preview,
    required this.x96,
    required this.x48,
  });

  ///Converts from json
  factory ImageDTO.fromJson(Map<String, dynamic> json) =>
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
