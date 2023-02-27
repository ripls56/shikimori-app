import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:shikimori_app/core/usecase/usecase.dart';
import 'package:shikimori_app/feature/domain/entities/user_rate/user_rate.dart';
import 'package:shikimori_app/feature/domain/repositories/user_rate_repository.dart';

class AddAnimeInUserRates
    extends UseCase<List<UserRate>, AddAnimeInUserRatesParams> {
  final UserRateRepository userRateRepository;

  AddAnimeInUserRates(this.userRateRepository);

  @override
  Future<Either<Failure, List<UserRate>>> call(
      AddAnimeInUserRatesParams params) async {
    return await userRateRepository.addAnimeInUserRates(params.userRate);
  }
}

class AddAnimeInUserRatesParams extends Equatable {
  final UserRate userRate;

  const AddAnimeInUserRatesParams({required this.userRate});

  @override
  List<Object?> get props => [userRate];
}
