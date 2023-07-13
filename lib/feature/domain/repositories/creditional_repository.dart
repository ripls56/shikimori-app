import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';

///User creditional repository
abstract interface class CreditionalRepository {
  ///Get user creditionals with access token
  Future<Either<Failure, Creditional>> getCreditionals(String token);
}
