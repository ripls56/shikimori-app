import 'package:equatable/equatable.dart';

class UserRate extends Equatable {
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

  final int id;
  final int userId;
  final int targetId;
  final String targetType;
  final int score;
  final String status;
  final int rewatches;
  final int episodes;
  final int volumes;
  final int chapters;
  final String? text;
  final String textHtml;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [];
}
