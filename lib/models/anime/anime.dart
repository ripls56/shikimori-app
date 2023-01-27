import 'package:shikimori_app/features.dart';
part 'image.dart';
part 'kind.dart';
part 'status.dart';

class Anime {
  Anime({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.kind,
    required this.score,
    required this.status,
    required this.episodes,
    required this.episodesAired,
    required this.airedOn,
    this.releasedOn,
  });

  final int id;
  final String name;
  final String russian;
  final Image image;
  final String url;
  final Kind kind;
  final String score;
  final Status status;
  final int episodes;
  final int episodesAired;
  final DateTime airedOn;
  final DateTime? releasedOn;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        id: json["id"],
        name: json["name"],
        russian: json["russian"],
        image: Image.fromJson(json["image"]),
        url: json["url"],
        kind: kindValues.map[json["kind"]]!,
        score: json["score"],
        status: statusValues.map[json["status"]]!,
        episodes: json["episodes"],
        episodesAired: json["episodes_aired"],
        airedOn: DateTime.parse(json["aired_on"]),
        releasedOn: json["released_on"] == null
            ? null
            : DateTime.parse(json["released_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "russian": russian,
        "image": image.toJson(),
        "url": url,
        "kind": kindValues.reverse[kind],
        "score": score,
        "status": statusValues.reverse[status],
        "episodes": episodes,
        "episodes_aired": episodesAired,
        "aired_on":
            "${airedOn.year.toString().padLeft(4, '0')}-${airedOn.month.toString().padLeft(2, '0')}-${airedOn.day.toString().padLeft(2, '0')}",
        "released_on":
            "${releasedOn!.year.toString().padLeft(4, '0')}-${releasedOn!.month.toString().padLeft(2, '0')}-${releasedOn!.day.toString().padLeft(2, '0')}",
      };
}
