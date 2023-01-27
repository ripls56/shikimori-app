part of 'creditional.dart';

class Image {
  Image({
    required this.x160,
    required this.x148,
    required this.x80,
    required this.x64,
    required this.x48,
    required this.x32,
    required this.x16,
  });

  final String x160;
  final String x148;
  final String x80;
  final String x64;
  final String x48;
  final String x32;
  final String x16;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        x160: json["x160"],
        x148: json["x148"],
        x80: json["x80"],
        x64: json["x64"],
        x48: json["x48"],
        x32: json["x32"],
        x16: json["x16"],
      );

  Map<String, dynamic> toJson() => {
        "x160": x160,
        "x148": x148,
        "x80": x80,
        "x64": x64,
        "x48": x48,
        "x32": x32,
        "x16": x16,
      };
}
