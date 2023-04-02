// enum Status { released, ongoing }

// final statusValues =
//     EnumValues({"ongoing": Status.ongoing, "released": Status.released});

import 'package:equatable/equatable.dart';

class Status extends Equatable {
  const Status({required this.statusName});

  final String statusName;

  @override
  List<Object?> get props => [];
}
