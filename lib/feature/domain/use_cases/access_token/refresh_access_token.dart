import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/repositories/refresh_access_token_repository.dart';

class RefreshAccessToken extends UseCase<UserAuth, RefreshAccessTokenParams> {
  final RefreshAccessTokenRepository refreshAccessTokenRepository;

  RefreshAccessToken(this.refreshAccessTokenRepository);

  @override
  Future<Either<Failure, UserAuth>> call(
      RefreshAccessTokenParams params) async {
    return await refreshAccessTokenRepository.refreshAccessToken(
      params.grantType,
      params.identifier,
      params.secret,
      params.refreshToken,
    );
  }
}

class RefreshAccessTokenParams extends Equatable {
  final String grantType;
  final String identifier;
  final String secret;
  final String refreshToken;

  const RefreshAccessTokenParams({
    required this.grantType,
    required this.identifier,
    required this.secret,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [identifier, secret, refreshToken, grantType];
}
