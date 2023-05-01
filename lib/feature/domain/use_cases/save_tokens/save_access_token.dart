import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/repositories/save_tokens_repository.dart';

class SaveAccessToken extends UseCase<void, SaveAccessTokenParams> {
  final SaveAccessTokenRepository saveAccessTokenRepository;

  SaveAccessToken(this.saveAccessTokenRepository);

  @override
  Future<Either<Failure, void>> call(SaveAccessTokenParams params) async {
    return await saveAccessTokenRepository.saveAccessToken(params.accessToken);
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
