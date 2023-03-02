part of 'anime.dart';

// enum Kind { tv, movie, ova, ona }

// final kindValues = EnumValues(
//     {"movie": Kind.movie, "ona": Kind.ona, "ova": Kind.ova, "tv": Kind.tv});

class Kind extends Equatable {
  final String kindName;

  const Kind({required this.kindName});

  @override
  List<Object?> get props => [];
}
