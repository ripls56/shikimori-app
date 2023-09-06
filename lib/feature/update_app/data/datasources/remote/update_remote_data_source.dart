import 'package:shikimoriapp/core/error/exception.dart';

///Update remote data source
abstract class UpdateRemoteDataSource {
  ///Get update from api
  ///
  ///Throws [ServerException] for all code errors
  Future<void> getUpdate(String version, String path);
}
