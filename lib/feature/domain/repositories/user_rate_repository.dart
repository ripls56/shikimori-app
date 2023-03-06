import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';

abstract class UserRateRepository {
  ///Get user rate list with user id
  Future<Either<Failure, List<UserRate>>> getUserRates(int id);

  ///Add anime in user rate list
  Future<Either<Failure, List<UserRate>>> addAnimeInUserRates(UserRate rate);
}
