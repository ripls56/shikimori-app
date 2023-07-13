part of 'anime_details.dart';

class RatesScoresStatModel extends RatesScoresStat {
  const RatesScoresStatModel({
    required name,
    required value,
  }) : super(name: name, value: value);

  factory RatesScoresStatModel.fromJson(Map<String, dynamic> json) =>
      RatesScoresStatModel(
        name: json['name'],
        value: json['value'],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
