import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/repositories/tokens_repository.dart';

class GetAccessTokenFromStorage extends UseCase<void, NoParams> {
  GetAccessTokenFromStorage(this.tokenLocalRepository);
  final TokenLocalRepository tokenLocalRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return tokenLocalRepository.getAccessToken();
  }
}
