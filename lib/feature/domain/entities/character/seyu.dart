part of 'character.dart';

class Seyu extends Equatable {
  const Seyu({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
  });

  final int id;
  final String name;
  final String russian;
  final Image image;
  final String url;

  @override
  List<Object?> get props => [];
}
