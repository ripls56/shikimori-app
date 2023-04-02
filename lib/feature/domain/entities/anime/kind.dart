// enum Kind { tv, movie, ova, ona }

// final kindValues = EnumValues(
//     {"movie": Kind.movie, "ona": Kind.ona, "ova": Kind.ova, "tv": Kind.tv});

import 'package:equatable/equatable.dart';

class Kind extends Equatable {
  final String kindName;

  const Kind({required this.kindName});

  @override
  List<Object?> get props => [];
}
