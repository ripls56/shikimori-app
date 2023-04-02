import 'package:equatable/equatable.dart';

class Image extends Equatable {
  const Image({
    this.original,
    this.preview,
    this.x96,
    this.x48,
  });

  final String? original;
  final String? preview;
  final String? x96;
  final String? x48;

  @override
  List<Object?> get props => [];
}
