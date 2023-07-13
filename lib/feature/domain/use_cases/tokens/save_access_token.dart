import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/repositories/tokens_repository.dart';

class SaveAccessToken extends UseCase<void, SaveAccessTokenParams> {
  final TokenLocalRepository tokenLocalRepository;

  SaveAccessToken(this.tokenLocalRepository);

  @override
  Future<Either<Failure, void>> call(SaveAccessTokenParams params) async {
    return await tokenLocalRepository.saveAccessToken(params.accessToken);
  }
}

class SaveAccessTokenParams extends Equatable {
  final String accessToken;

  const SaveAccessTokenParams({required this.accessToken});

  @override
  List<Object?> get props => [
        accessToken,
      ];
}
