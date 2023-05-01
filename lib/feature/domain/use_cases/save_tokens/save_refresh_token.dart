import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/repositories/save_tokens_repository.dart';

class SaveRefreshToken extends UseCase<void, SaveRefreshTokenParams> {
  final SaveRefreshTokenRepository saveRefreshTokenRepository;

  SaveRefreshToken(this.saveRefreshTokenRepository);

  @override
  Future<Either<Failure, void>> call(SaveRefreshTokenParams params) async {
    return await saveRefreshTokenRepository
        .saveRefreshToken(params.refreshToken);
  }
}

class SaveRefreshTokenParams extends Equatable {
  final String refreshToken;

  const SaveRefreshTokenParams({required this.refreshToken});

  @override
  List<Object?> get props => [
        refreshToken,
      ];
}
