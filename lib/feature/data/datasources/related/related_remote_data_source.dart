import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

abstract class RelatedRemoteDataSource {
  ///Get related with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Related>> getRelated(int id);
}
