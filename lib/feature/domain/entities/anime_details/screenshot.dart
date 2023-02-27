part of 'anime_details.dart';

class Screenshot extends Equatable {
  const Screenshot({
    required this.original,
    required this.preview,
  });

  final String original;
  final String preview;

  @override
  List<Object?> get props => [];
}
