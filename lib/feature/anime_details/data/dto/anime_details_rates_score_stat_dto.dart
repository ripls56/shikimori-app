import 'package:json_annotation/json_annotation.dart';

part 'anime_details_rates_score_stat_dto.g.dart';

///Rates scores stat data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsRatesScoresStatDTO {
  ///Constructor
  const AnimeDetailsRatesScoresStatDTO({
    required this.name,
    required this.value,
  });

  factory AnimeDetailsRatesScoresStatDTO.fromJson(Map<String, dynamic> json) =>
      _$RatesScoresStatDTOFromJson(json);

  ///Rates scores stat name
  final int name;

  ///Rates scores stat value
  final int value;
}
