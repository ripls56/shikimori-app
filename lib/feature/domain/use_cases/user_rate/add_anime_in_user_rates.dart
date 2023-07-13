import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';
import 'package:shikimoriapp/feature/domain/repositories/user_rate_repository.dart';

class AddAnimeInUserRates
    extends UseCase<List<UserRate>, AddAnimeInUserRatesParams> {

  AddAnimeInUserRates(this.userRateRepository);
  final UserRateRepository userRateRepository;

  @override
  Future<Either<Failure, List<UserRate>>> call(
      AddAnimeInUserRatesParams params,) async {
    return await userRateRepository.addAnimeInUserRates(params.userRate);
  }
}

class AddAnimeInUserRatesParams extends Equatable {

  const AddAnimeInUserRatesParams({required this.userRate});
  final UserRate userRate;

  @override
  List<Object?> get props => [userRate];
}
