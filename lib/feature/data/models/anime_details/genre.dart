part of 'anime_details.dart';

class GenreModel extends Genre {
  const GenreModel({
    required id,
    required name,
    required russian,
    required kind,
  }) : super(id: id, name: name, russian: russian, kind: kind);

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json['id'],
        name: json['name'],
        russian: json['russian'],
        kind: json['kind'],
      );

  @override
  List<Object?> get props => [];
}
