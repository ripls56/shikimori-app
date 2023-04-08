part of 'character.dart';

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
    required releasedOn,
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
            airedOn: airedOn,
            releasedOn: releasedOn);

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
        airedOn: DateTime.parse(json["aired_on"]),
        releasedOn: json["released_on"] == null
            ? null
            : DateTime.parse(json["released_on"]),
      );

  @override
  List<Object?> get props => [];
}
