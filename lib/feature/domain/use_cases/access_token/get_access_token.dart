import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/repositories/user_auth_repository.dart';

class GetAccessToken extends UseCase<UserAuth, GetAccessTokenParams> {

  GetAccessToken(this.userGetAccessTokenRepository);
  final UserAuthRepository userGetAccessTokenRepository;

  @override
  Future<Either<Failure, UserAuth>> call(GetAccessTokenParams params) async {
    return await userGetAccessTokenRepository.getAccessToken(params.grantType,
        params.identifier, params.secret, params.code, params.redirectUri,);
  }
}

class GetAccessTokenParams extends Equatable {

  const GetAccessTokenParams(
      {required this.grantType,
      required this.code,
      required this.redirectUri,
      required this.identifier,
      required this.secret,});
  final String grantType;
  final String identifier;
  final String secret;
  final String code;
  final Uri redirectUri;

  @override
  List<Object?> get props => [identifier, secret, code, redirectUri];
}
