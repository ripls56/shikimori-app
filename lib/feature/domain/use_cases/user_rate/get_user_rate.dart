import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';
import 'package:shikimoriapp/feature/domain/repositories/user_rate_repository.dart';

class GetUserRate extends UseCase<List<UserRate>, GetUserRateParams> {
  final UserRateRepository userRateRepository;

  GetUserRate(this.userRateRepository);

  @override
  Future<Either<Failure, List<UserRate>>> call(GetUserRateParams params) async {
    return await userRateRepository.getUserRates(params.id);
  }
}

class GetUserRateParams extends Equatable {
  final int id;

  const GetUserRateParams({required this.id});

  @override
  List<Object?> get props => [id];
}
