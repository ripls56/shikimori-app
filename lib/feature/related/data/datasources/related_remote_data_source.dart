import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';

///Anime related data source
abstract interface class RelatedRemoteDataSource {
  ///Get related with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Related>> getRelated(int id);
}
