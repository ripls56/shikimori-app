import 'package:shikimoriapp/feature/domain/entities/anime/image.dart';

class ImageModel extends Image {
  const ImageModel({
    required original,
    required preview,
    required x96,
    required x48,
  }) : super(original: original, preview: preview, x96: x96, x48: x48);

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        original: json["original"],
        preview: json["preview"],
        x96: json["x96"],
        x48: json["x48"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "preview": preview,
        "x96": x96,
        "x48": x48,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
