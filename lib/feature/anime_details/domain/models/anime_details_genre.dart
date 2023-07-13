import 'package:equatable/equatable.dart';

///Genre model
class AnimeDetailsGenre extends Equatable {
  ///Constructor
  const AnimeDetailsGenre({
    required this.id,
    required this.name,
    required this.russian,
    required this.kind,
  });

  ///Genre id
  final int? id;

  ///Genre name
  final String? name;

  ///Genre russian name
  final String? russian;

  ///Genre kind
  final String? kind;

  @override
  List<Object?> get props => [];
}
