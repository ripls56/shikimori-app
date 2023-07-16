import 'package:equatable/equatable.dart';

///User rate model
class UserRate extends Equatable {
  ///Constructor
  const UserRate({
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

  @override
  List<Object?> get props => [
        id,
        userId,
        targetId,
        targetType,
        score,
        status,
        rewatches,
        episodes,
        volumes,
        chapters,
        text,
        textHtml,
        createdAt,
        updatedAt,
      ];
}
