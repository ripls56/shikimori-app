import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source.dart';
import 'package:shikimoriapp/feature/domain/repositories/save_tokens_repository.dart';

class SaveRefreshTokenRepositoryImpl implements SaveRefreshTokenRepository {
  final TokenLocalDataSource tokenLocalDataSource;

  SaveRefreshTokenRepositoryImpl(this.tokenLocalDataSource);

  @override
  Future<Either<Failure, void>> saveRefreshToken(String token) async {
    return _saveRefreshToken(
        () => tokenLocalDataSource.saveRefreshToken(token));
  }

  Future<Either<Failure, void>> _saveRefreshToken(
      Future<void> Function() token) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return Left(LocalFailure());
    }
  }
}
