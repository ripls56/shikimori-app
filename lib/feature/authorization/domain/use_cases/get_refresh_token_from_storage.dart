import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/authorization/domain/repositories/tokens_repository.dart';

import '../../../../core/usecase/no_params.dart';

class GetRefreshTokenFromStorage extends UseCase<void, NoParams> {
  GetRefreshTokenFromStorage(this.tokenLocalRepository);
  final TokenLocalRepository tokenLocalRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return tokenLocalRepository.getRefreshToken();
  }
}
