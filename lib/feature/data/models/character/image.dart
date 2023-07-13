part of 'character.dart';

class ImageModel extends Image {
  const ImageModel({
    required super.original,
    required super.preview,
    required super.x96,
    required super.x48,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        original: json['original'],
        preview: json['preview'],
        x96: json['x96'],
        x48: json['x48'],
      );

  @override
  List<Object?> get props => [];
}
