import 'package:json_annotation/json_annotation.dart';

part 'anime_details_rates_statuses_stat_dto.g.dart';

///Rates statuses stat data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsRatesStatusesStatDTO {
  ///Constructor
  const AnimeDetailsRatesStatusesStatDTO({
    required this.name,
    required this.value,
  });

  factory AnimeDetailsRatesStatusesStatDTO.fromJson(
          Map<String, dynamic> json) =>
      _$RatesStatusesStatDTOFromJson(json);

  ///Rates statuses stat name
  final String name;

  ///Rates statuses stat value
  final int value;
}
