part of 'anime_details.dart';

class ScreenshotModel extends Screenshot {
  const ScreenshotModel({
    required original,
    required preview,
  }) : super(original: original, preview: preview);

  factory ScreenshotModel.fromJson(Map<String, dynamic> json) =>
      ScreenshotModel(
        original: json["original"],
        preview: json["preview"],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
