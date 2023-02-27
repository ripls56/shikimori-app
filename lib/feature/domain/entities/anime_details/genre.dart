part of 'anime_details.dart';

class Genre extends Equatable {
  const Genre({
    required this.id,
    required this.name,
    required this.russian,
    required this.kind,
  });

  final int id;
  final String name;
  final String russian;
  final String kind;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
