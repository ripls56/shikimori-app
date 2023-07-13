import 'package:equatable/equatable.dart';

///Studio model
class AnimeDetailsStudio extends Equatable {
  ///Constructor
  const AnimeDetailsStudio({
    required this.id,
    required this.name,
    required this.filteredName,
    required this.real,
    required this.image,
  });

  ///Studio id
  final int? id;

  ///Studio name
  final String? name;

  ///Studio filtered name
  final String? filteredName;

  ///Studio real
  final bool? real;

  ///Studio image
  final String? image;

  @override
  List<Object?> get props => [];
}
