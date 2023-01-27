part of 'anime_details.dart';

class Video {
  Video({
    required this.id,
    required this.url,
    required this.imageUrl,
    required this.playerUrl,
    required this.name,
    required this.kind,
    required this.hosting,
  });

  final int id;
  final String url;
  final String imageUrl;
  final String playerUrl;
  final String name;
  final String kind;
  final String hosting;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        url: json["url"],
        imageUrl: json["image_url"],
        playerUrl: json["player_url"],
        name: json["name"],
        kind: json["kind"],
        hosting: json["hosting"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "image_url": imageUrl,
        "player_url": playerUrl,
        "name": name,
        "kind": kind,
        "hosting": hosting,
      };
}
