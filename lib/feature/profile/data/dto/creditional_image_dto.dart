import 'package:json_annotation/json_annotation.dart';

part 'creditional_image_dto.g.dart';

///User creditional image data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class CreditionalImageDTO {
  ///Constructor
  const CreditionalImageDTO({
    required this.x160,
    required this.x148,
    required this.x80,
    required this.x64,
    required this.x48,
    required this.x32,
    required this.x16,
  });

  factory CreditionalImageDTO.fromJson(Map<String, dynamic> json) =>
      _$CreditionalImageDTOFromJson(json);

  ///Image 160x160
  final String x160;

  ///Image 148x148
  final String x148;

  ///Image 80x80
  final String x80;

  ///Image 64x64
  final String x64;

  ///Image 48x48
  final String x48;

  ///Image 32x32
  final String x32;

  ///Image 16x16
  final String x16;

  @override
  List<Object?> get props => [x160, x148, x80, x64, x48, x32, x16];
}
