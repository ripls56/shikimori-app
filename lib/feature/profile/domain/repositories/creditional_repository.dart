import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';

///User creditional repository
abstract interface class CreditionalRepository {
  ///Get user creditionals with access token
  Future<Either<Failure, Creditional>> getCreditionals(String token);
}
