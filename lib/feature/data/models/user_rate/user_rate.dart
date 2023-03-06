import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';

class UserRateModel extends UserRate {
  const UserRateModel({
    required id,
    required userId,
    required targetId,
    required targetType,
    required score,
    required status,
    required rewatches,
    required episodes,
    required volumes,
    required chapters,
    required text,
    required textHtml,
    required createdAt,
    required updatedAt,
  }) : super(
            id: id,
            userId: userId,
            targetId: targetId,
            targetType: targetType,
            score: score,
            status: status,
            rewatches: rewatches,
            episodes: episodes,
            volumes: volumes,
            chapters: chapters,
            text: text,
            textHtml: textHtml,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory UserRateModel.fromJson(Map<String, dynamic> json) => UserRateModel(
        id: json["id"],
        userId: json["user_id"],
        targetId: json["target_id"],
        targetType: json["target_type"],
        score: json["score"],
        status: json["status"],
        rewatches: json["rewatches"],
        episodes: json["episodes"],
        volumes: json["volumes"],
        chapters: json["chapters"],
        text: json["text"],
        textHtml: json["text_html"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "target_id": targetId,
        "target_type": targetType,
        "score": score,
        "status": status,
        "rewatches": rewatches,
        "episodes": episodes,
        "volumes": volumes,
        "chapters": chapters,
        "text": text,
        "text_html": textHtml,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [];
}
