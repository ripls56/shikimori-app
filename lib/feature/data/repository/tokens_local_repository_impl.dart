import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source.dart';
import 'package:shikimoriapp/feature/domain/repositories/tokens_repository.dart';

///
class TokensLocalRepositoryImpl implements TokenLocalRepository {
  TokensLocalRepositoryImpl(this._tokenLocalDataSource);

  final TokenLocalDataSource _tokenLocalDataSource;

  @override
  Future<Either<Failure, void>> saveAccessToken(String token) async {
    return _saveAccessToken(() => _tokenLocalDataSource.saveAccessToken(token));
  }

  Future<Either<Failure, void>> _saveAccessToken(
    Future<void> Function() token,
  ) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return const Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveRefreshToken(String token) async {
    return _saveRefreshToken(
      () => _tokenLocalDataSource.saveRefreshToken(token),
    );
  }

  Future<Either<Failure, void>> _saveRefreshToken(
    Future<void> Function() token,
  ) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return const Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTokens() {
    return _deleteTokens(_tokenLocalDataSource.deleteTokens);
  }

  Future<Either<Failure, void>> _deleteTokens(
    Future<void> Function() token,
  ) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return const Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken() {
    return _getAccessToken(_tokenLocalDataSource.getAccessToken);
  }

  Future<Either<Failure, String>> _getAccessToken(
    Future<String> Function() token,
  ) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return const Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getRefreshToken() {
    return _getRefreshToken(_tokenLocalDataSource.getRefreshToken);
  }

  Future<Either<Failure, String>> _getRefreshToken(
    Future<String> Function() token,
  ) async {
    try {
      final model = await token();
      return Right(model);
    } catch (_) {
      return const Left(LocalFailure());
    }
  }
}
