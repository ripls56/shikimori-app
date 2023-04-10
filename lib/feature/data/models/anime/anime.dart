import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';

import 'image.dart';

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
        kind: json["kind"],
        score: json["score"],
        status: json["status"],
        episodes: json["episodes"],
        episodesAired: json["episodes_aired"],
        airedOn:
            json["aired_on"] == null ? null : DateTime.parse(json["aired_on"]),
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
        "kind": kind,
        "score": score,
        "status": status,
        "episodes": episodes,
        "episodes_aired": episodesAired,
        "aired_on":
            "${airedOn?.year.toString().padLeft(4, '0')}-${airedOn?.month.toString().padLeft(2, '0')}-${airedOn?.day.toString().padLeft(2, '0')}",
        "released_on":
            "${releasedOn!.year.toString().padLeft(4, '0')}-${releasedOn!.month.toString().padLeft(2, '0')}-${releasedOn!.day.toString().padLeft(2, '0')}",
      };

  @override
  List<Object?> get props => [];
}
