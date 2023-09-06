import 'package:shikimoriapp/core/error/exception.dart';

///Update local data source
abstract class UpdateLocalDataSource {
  ///Update application with apk file
  ///
  ///Throws [UpdateException] for all code errors
  Future<void> update(String path);
}
