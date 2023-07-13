part of 'creditional.dart';

class ImageModel extends Image {
  const ImageModel({
    required x160,
    required x148,
    required x80,
    required x64,
    required x48,
    required x32,
    required x16,
  }) : super(
            x160: x160,
            x148: x148,
            x80: x80,
            x64: x64,
            x48: x48,
            x32: x32,
            x16: x16,);

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        x160: json['x160'],
        x148: json['x148'],
        x80: json['x80'],
        x64: json['x64'],
        x48: json['x48'],
        x32: json['x32'],
        x16: json['x16'],
      );

  Map<String, dynamic> toJson() => {
        'x160': x160,
        'x148': x148,
        'x80': x80,
        'x64': x64,
        'x48': x48,
        'x32': x32,
        'x16': x16,
      };

  @override
  List<Object?> get props => [];
}
