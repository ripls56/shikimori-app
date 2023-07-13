part of 'character.dart';

class SeyuModel extends Seyu {
  const SeyuModel({
    required id,
    required name,
    required russian,
    required image,
    required url,
  }) : super(id: id, name: name, russian: russian, image: image, url: url);

  factory SeyuModel.fromJson(Map<String, dynamic> json) => SeyuModel(
        id: json['id'],
        name: json['name'],
        russian: json['russian'],
        image: ImageModel.fromJson(json['image']),
        url: json['url'],
      );
}
