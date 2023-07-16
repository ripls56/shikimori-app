import 'package:json_annotation/json_annotation.dart';

part 'user_rate_dto.g.dart';

///User rate data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class UserRateDTO {
  ///Constructor
  const UserRateDTO({
    required this.id,
    required this.userId,
    required this.targetId,
    required this.targetType,
    required this.score,
    required this.status,
    required this.rewatches,
    required this.episodes,
    required this.volumes,
    required this.chapters,
    required this.text,
    required this.textHtml,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserRateDTO.fromJson(Map<String, dynamic> json) =>
      _$UserRateDTOFromJson(json);

  ///User rate id
  final int id;

  ///User id
  final int userId;

  ///Target id
  final int targetId;

  ///Target type
  final String targetType;

  ///Score
  final int score;

  ///Status
  final String status;

  ///Rewatches
  final int rewatches;

  ///Episodes
  final int episodes;

  ///Volumes
  final int volumes;

  ///Chapters
  final int chapters;

  ///Text
  final String? text;

  ///Text html
  final String textHtml;

  ///Created at
  final DateTime createdAt;

  ///Updated at
  final DateTime updatedAt;
}
