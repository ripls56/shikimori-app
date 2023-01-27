part of 'anime_details.dart';

class Studio {
  Studio({
    required this.id,
    required this.name,
    required this.filteredName,
    required this.real,
    required this.image,
  });

  final int id;
  final String name;
  final String filteredName;
  final bool real;
  final String image;

  factory Studio.fromJson(Map<String, dynamic> json) => Studio(
        id: json["id"],
        name: json["name"],
        filteredName: json["filtered_name"],
        real: json["real"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "filtered_name": filteredName,
        "real": real,
        "image": image,
      };
}
