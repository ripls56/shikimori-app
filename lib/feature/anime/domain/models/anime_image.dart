import 'package:equatable/equatable.dart';

///Image model
class AnimeImage extends Equatable {
  ///Constructor
  const AnimeImage({
    required this.original,
    required this.preview,
    required this.x96,
    required this.x48,
  });

  ///Image original
  final String original;

  ///Image preview
  final String preview;

  ///Image size x96
  final String x96;

  ///Image size x48
  final String x48;

  @override
  List<Object?> get props => throw UnimplementedError();
}
