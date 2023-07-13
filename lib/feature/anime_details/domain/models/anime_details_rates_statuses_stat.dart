import 'package:equatable/equatable.dart';

///Rates statuses stat model
class AnimeDetailsRatesStatusesStat extends Equatable {
  ///Constructor
  const AnimeDetailsRatesStatusesStat({
    required this.name,
    required this.value,
  });

  ///Rates statuses stat name
  final String name;

  ///Rates statuses stat value
  final int value;

  @override
  List<Object?> get props => [];
}
