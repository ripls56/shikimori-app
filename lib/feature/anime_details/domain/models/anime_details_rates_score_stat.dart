import 'package:equatable/equatable.dart';

///Rates scores stat model
class AnimeDetailsRatesScoresStat extends Equatable {
  ///Constructor
  const AnimeDetailsRatesScoresStat({
    required this.name,
    required this.value,
  });

  ///Rates scores stat name
  final int name;

  ///Rates scores stat value
  final int value;

  @override
  List<Object?> get props => [];
}
