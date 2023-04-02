part of 'manga_details.dart';

class Image extends Equatable {
  const Image({
    required this.original,
    required this.preview,
    required this.x96,
    required this.x48,
  });

  final String? original;
  final String? preview;
  final String? x96;
  final String? x48;

  @override
  List<Object?> get props => [];
}
