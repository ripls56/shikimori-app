import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source.dart';
import 'package:shikimoriapp/feature/domain/repositories/save_tokens_repository.dart';

class SaveAccessTokenRepositoryImpl implements SaveAccessTokenRepository {
  final TokenLocalDataSource tokenLocalDataSource;

  SaveAccessTokenRepositoryImpl(this.tokenLocalDataSource);

  @override
  Future<Either<Failure, void>> saveAccessToken(String token) async {
    return _saveAccessToken(() => tokenLocalDataSource.saveAccessToken(token));
  }

  Future<Either<Failure, void>> _saveAccessToken(
      Future<void> Function() token) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return Left(LocalFailure());
    }
  }
}
