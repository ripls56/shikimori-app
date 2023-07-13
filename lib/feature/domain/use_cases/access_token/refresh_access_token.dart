import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/repositories/user_auth_repository.dart';

class RefreshAccessToken extends UseCase<UserAuth, RefreshAccessTokenParams> {
  RefreshAccessToken(this._userAuthRepository);

  final UserAuthRepository _userAuthRepository;

  @override
  Future<Either<Failure, UserAuth>> call(
    RefreshAccessTokenParams params,
  ) async {
    return _userAuthRepository.refreshAccessToken(
      params.grantType,
      params.identifier,
      params.secret,
      params.refreshToken,
    );
  }
}

///Params for use case [RefreshAccessToken]
class RefreshAccessTokenParams extends Equatable {
  ///Params for use case [RefreshAccessToken]
  const RefreshAccessTokenParams({
    required this.grantType,
    required this.identifier,
    required this.secret,
    required this.refreshToken,
  });

  ///Grant type
  final String grantType;

  ///App identifier
  final String identifier;

  ///App secret
  final String secret;

  ///App current refresh token
  final String refreshToken;

  @override
  List<Object?> get props => [identifier, secret, refreshToken, grantType];
}
