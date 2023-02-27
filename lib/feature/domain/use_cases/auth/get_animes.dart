import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:shikimori_app/core/usecase/usecase.dart';
import 'package:shikimori_app/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimori_app/feature/domain/repositories/user_auth_repository.dart';

class Auth extends UseCase<UserAuth, AuthParams> {
  final UserAuthRepository userAuthRepository;

  Auth(this.userAuthRepository);

  @override
  Future<Either<Failure, UserAuth>> call(AuthParams params) async {
    return await userAuthRepository.auth(
        params.identifier, params.secret, params.code, params.redirectUri);
  }
}

class AuthParams extends Equatable {
  final String identifier;
  final String secret;
  final String code;
  final Uri redirectUri;

  const AuthParams(
      {required this.code,
      required this.redirectUri,
      required this.identifier,
      required this.secret});

  @override
  List<Object?> get props => [identifier, secret, code, redirectUri];
}
