import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/update_app/data/datasources/local/update_local_data_source.dart';
import 'package:shikimoriapp/feature/update_app/data/datasources/remote/update_remote_data_source.dart';
import 'package:shikimoriapp/feature/update_app/domain/repositories/update_repository.dart';

///Update repository implementation
class UpdateRepositoryImpl implements UpdateRepository{
  ///Constructor
  UpdateRepositoryImpl(this._updateLocalDataSource, this._updateRemoteDataSource);


  final UpdateLocalDataSource _updateLocalDataSource;
  final UpdateRemoteDataSource _updateRemoteDataSource;

  @override
  Future<Either<Failure, void>> getUpdate(String currentVersion, String path) async => _getUpdate(() => _updateRemoteDataSource.getUpdate(currentVersion, path,),);


  Future<Either<Failure, void>> _getUpdate(
      Future<void> Function() value,
      ) async {
    try {
      final model = await value();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateApp(String path) => _updateApp(() => _updateLocalDataSource.update(path),);

  Future<Either<Failure, void>> _updateApp(
      Future<void> Function() value,
      ) async {
    try {
      final model = await value();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

}