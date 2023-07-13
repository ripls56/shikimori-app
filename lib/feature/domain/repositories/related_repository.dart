import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

///Anime related repository
abstract interface class RelatedRepository {
  ///Get related
  Future<Either<Failure, List<Related>>> getRelated(int id);
}
