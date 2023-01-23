class UserRates {
  UserRates({
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

  int id;
  int userId;
  int targetId;
  String targetType;
  int score;
  String status;
  int rewatches;
  int episodes;
  int volumes;
  int chapters;
  String text;
  String textHtml;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserRates.fromJson(Map<String, dynamic> json) => UserRates(
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
}
