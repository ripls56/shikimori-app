import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/update_app/domain/repositories/update_repository.dart';

///Get update from api
class UpdateApp extends UseCase<void, UpdateAppParams> {
  ///Constructor
  UpdateApp(this._updateRepository);
  final UpdateRepository _updateRepository;

  @override
  Future<Either<Failure, void>> call(UpdateAppParams params) async {
    return _updateRepository.updateApp(params.path);
  }
}

///Params for [UpdateApp]
class UpdateAppParams extends Equatable {
  ///Constructor
  const UpdateAppParams({required this.path,});
  ///Path to apk file
  final String path;

  @override
  List<Object?> get props => [path];
}
