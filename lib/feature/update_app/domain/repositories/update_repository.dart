import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';

///Update repository
abstract interface class UpdateRepository{
  ///If exist get application update from api
  Future<Either<Failure, void>> getUpdate(String currentVersion, String path);

  ///Update application with apk file
  Future<Either<Failure, void>> updateApp(String path);
}