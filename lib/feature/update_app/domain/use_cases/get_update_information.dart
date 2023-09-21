import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/update_app/domain/repositories/update_repository.dart';

///Get update information from api
class GetUpdateInformation extends UseCase<String, NoParams> {
  ///Constructor
  GetUpdateInformation(this._updateRepository);
  final UpdateRepository _updateRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return _updateRepository.getUpdateInformation();
  }
}
