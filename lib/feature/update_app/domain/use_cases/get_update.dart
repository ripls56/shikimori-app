import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/update_app/domain/repositories/update_repository.dart';

///Get update from api
class GetUpdate extends UseCase<void, GetUpdateParams> {
  ///Constructor
  GetUpdate(this._updateRepository);
  final UpdateRepository _updateRepository;

  @override
  Future<Either<Failure, void>> call(GetUpdateParams params) async {
    return _updateRepository.getUpdate(params.version, params.path);
  }
}

///Params for [GetUpdate]
class GetUpdateParams extends Equatable {
  ///Constructor
  const GetUpdateParams({required this.version, required this.path,});
  ///Version of application
  final String version;
  ///Path to apk file
  final String path;

  @override
  List<Object?> get props => [version, path];
}
