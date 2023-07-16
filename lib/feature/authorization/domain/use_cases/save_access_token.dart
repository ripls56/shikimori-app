import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/authorization/domain/repositories/tokens_repository.dart';

class SaveAccessToken extends UseCase<void, SaveAccessTokenParams> {
  SaveAccessToken(this.tokenLocalRepository);
  final TokenLocalRepository tokenLocalRepository;

  @override
  Future<Either<Failure, void>> call(SaveAccessTokenParams params) async {
    return await tokenLocalRepository.saveAccessToken(params.accessToken);
  }
}

class SaveAccessTokenParams extends Equatable {
  const SaveAccessTokenParams({required this.accessToken});
  final String accessToken;

  @override
  List<Object?> get props => [
        accessToken,
      ];
}
