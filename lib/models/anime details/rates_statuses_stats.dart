part of 'anime_details.dart';

class RatesStatusesStat {
  RatesStatusesStat({
    required this.name,
    required this.value,
  });

  final String name;
  final int value;

  factory RatesStatusesStat.fromJson(Map<String, dynamic> json) =>
      RatesStatusesStat(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
