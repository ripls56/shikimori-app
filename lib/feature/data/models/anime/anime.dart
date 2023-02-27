import 'package:shikimori_app/feature/domain/entities/anime/anime.dart';
import 'package:shikimori_app/features.dart';
part 'image.dart';
part 'kind.dart';
part 'status.dart';

class AnimeModel extends Anime {
  const AnimeModel({
    required id,
    required name,
    required russian,
    required image,
    required url,
    required kind,
    required score,
    required status,
    required episodes,
    required episodesAired,
    required airedOn,
    releasedOn,
  }) : super(
            id: id,
            name: name,
            russian: russian,
            image: image,
            url: url,
            kind: kind,
            score: score,
            status: status,
            episodes: episodes,
            episodesAired: episodesAired,
            airedOn: airedOn);

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        id: json["id"],
        name: json["name"],
        russian: json["russian"],
        image: ImageModel.fromJson(json["image"]),
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
        "image": image,
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

  @override
  List<Object?> get props => [];
}
