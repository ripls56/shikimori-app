part of 'anime_details.dart';

class RatesStatusesStatModel extends RatesStatusesStat {
  const RatesStatusesStatModel({
    required name,
    required value,
  }) : super(name: name, value: value);

  factory RatesStatusesStatModel.fromJson(Map<String, dynamic> json) =>
      RatesStatusesStatModel(
        name: json["name"],
        value: json["value"],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
