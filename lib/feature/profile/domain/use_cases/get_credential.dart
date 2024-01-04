import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';
import 'package:shikimoriapp/feature/profile/domain/repositories/credential_repository.dart';

class GetCredential extends UseCase<Credential, GetCredentialParams> {
  GetCredential(this.credentialRepository);

  final CredentialRepository credentialRepository;

  @override
  Future<Either<Failure, Credential>> call(GetCredentialParams params) async {
    return await credentialRepository.getCredentials(params.accessToken);
  }
}

class GetCredentialParams extends Equatable {
  const GetCredentialParams({required this.accessToken});

  final String accessToken;

  @override
  List<Object?> get props => [accessToken];
}
