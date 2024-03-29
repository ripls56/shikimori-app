import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/profile/domain/models/user_rate.dart';
import 'package:shikimoriapp/feature/profile/domain/repositories/user_rate_repository.dart';

class GetUserRate extends UseCase<List<UserRate>, GetUserRateParams> {
  GetUserRate(this.userRateRepository);
  final UserRateRepository userRateRepository;

  @override
  Future<Either<Failure, List<UserRate>>> call(GetUserRateParams params) async {
    return await userRateRepository.getUserRates(params.id);
  }
}

class GetUserRateParams extends Equatable {
  const GetUserRateParams({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}
