import 'package:equatable/equatable.dart';

///Screenshot model
class AnimeDetailsScreenshot extends Equatable {
  ///Constructor
  const AnimeDetailsScreenshot({
    required this.original,
    required this.preview,
  });

  ///Screenshot original
  final String original;

  ///Screenshot preview
  final String preview;

  @override
  List<Object?> get props => [];
}
