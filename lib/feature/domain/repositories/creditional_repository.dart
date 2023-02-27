import 'package:dartz/dartz.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:shikimori_app/feature/domain/entities/creditional/creditional.dart';

abstract class CreditionalRepository {
  ///Get user creditionals with access token
  Future<Either<Failure, Creditional>> getCreditionals(String token);
}
