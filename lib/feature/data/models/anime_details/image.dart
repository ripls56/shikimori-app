part of 'anime_details.dart';

class Image extends Equatable {
  const Image({
    required this.original,
    required this.preview,
    required this.x96,
    required this.x48,
  });

  final String original;
  final String preview;
  final String x96;
  final String x48;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
  List<Object?> get props => [];
}
