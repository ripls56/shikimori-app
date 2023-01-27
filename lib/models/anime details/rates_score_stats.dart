part of 'anime_details.dart';

class RatesScoresStat {
  RatesScoresStat({
    required this.name,
    required this.value,
  });

  final int name;
  final int value;

  factory RatesScoresStat.fromJson(Map<String, dynamic> json) =>
      RatesScoresStat(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
