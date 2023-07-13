import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/repositories/tokens_repository.dart';

class SaveRefreshToken extends UseCase<void, SaveRefreshTokenParams> {

  SaveRefreshToken(this.tokenLocalRepository);
  final TokenLocalRepository tokenLocalRepository;

  @override
  Future<Either<Failure, void>> call(SaveRefreshTokenParams params) async {
    return await tokenLocalRepository.saveRefreshToken(params.refreshToken);
  }
}

class SaveRefreshTokenParams extends Equatable {

  const SaveRefreshTokenParams({required this.refreshToken});
  final String refreshToken;

  @override
  List<Object?> get props => [refreshToken];
}
