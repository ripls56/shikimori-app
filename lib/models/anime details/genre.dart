part of 'anime_details.dart';

class Genre {
  Genre({
    required this.id,
    required this.name,
    required this.russian,
    required this.kind,
  });

  final int id;
  final String name;
  final String russian;
  final String kind;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
        russian: json["russian"],
        kind: json["kind"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "russian": russian,
        "kind": kind,
      };
}
