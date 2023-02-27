part of 'anime_details.dart';

class VideoModel extends Video {
  const VideoModel({
    required id,
    required url,
    required imageUrl,
    required playerUrl,
    required name,
    required kind,
    required hosting,
  }) : super(
            id: id,
            url: url,
            imageUrl: imageUrl,
            playerUrl: playerUrl,
            name: name,
            kind: kind,
            hosting: hosting);

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        url: json["url"],
        imageUrl: json["image_url"],
        playerUrl: json["player_url"],
        name: json["name"],
        kind: json["kind"],
        hosting: json["hosting"],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
