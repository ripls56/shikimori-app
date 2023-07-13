import 'package:json_annotation/json_annotation.dart';

part 'anime_details_studio_dto.g.dart';

///Studio data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsStudioDTO {
  ///Constructor
  const AnimeDetailsStudioDTO({
    required this.id,
    required this.name,
    required this.filteredName,
    required this.real,
    required this.image,
  });

  factory AnimeDetailsStudioDTO.fromJson(Map<String, dynamic> json) =>
      _$StudioDTOFromJson(json);

  ///Studio id
  final int? id;

  ///Studio name
  final String? name;

  ///Studio filtered name
  final String? filteredName;

  ///Studio real
  final bool? real;

  ///Studio image
  final String? image;
}
