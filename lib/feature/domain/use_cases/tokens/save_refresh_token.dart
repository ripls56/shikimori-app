import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/repositories/tokens_repository.dart';

class SaveRefreshToken extends UseCase<void, SaveRefreshTokenParams> {
  final TokenLocalRepository tokenLocalRepository;

  SaveRefreshToken(this.tokenLocalRepository);

  @override
  Future<Either<Failure, void>> call(SaveRefreshTokenParams params) async {
    return await tokenLocalRepository.saveRefreshToken(params.refreshToken);
  }
}

class SaveRefreshTokenParams extends Equatable {
  final String refreshToken;

  const SaveRefreshTokenParams({required this.refreshToken});

  @override
  List<Object?> get props => [refreshToken];
}
