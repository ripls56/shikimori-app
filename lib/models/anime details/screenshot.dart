part of 'anime_details.dart';

class Screenshot {
  Screenshot({
    required this.original,
    required this.preview,
  });

  final String original;
  final String preview;

  factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
        original: json["original"],
        preview: json["preview"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "preview": preview,
      };
}
