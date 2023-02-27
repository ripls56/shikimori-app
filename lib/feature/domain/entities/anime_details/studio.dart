part of 'anime_details.dart';

class Studio extends Equatable {
  const Studio({
    required this.id,
    required this.name,
    required this.filteredName,
    required this.real,
    required this.image,
  });

  final int id;
  final String name;
  final String filteredName;
  final bool real;
  final String image;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
