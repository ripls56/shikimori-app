import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/authorization/domain/repositories/tokens_repository.dart';

class DeleteTokens extends UseCase<void, NoParams> {
  DeleteTokens(this.tokenLocalRepository);
  final TokenLocalRepository tokenLocalRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return tokenLocalRepository.deleteTokens();
  }
}
