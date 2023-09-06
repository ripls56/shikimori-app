import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/feature/download/service/download_service.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/get_update.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/update.dart';

part 'update_store.g.dart';

class UpdateStore = UpdateStoreBase with _$UpdateStore;

abstract class UpdateStoreBase with Store {
  UpdateStoreBase(
    this._getUpdateUseCase,
    this._updateAppUseCase,
    this._downloadService,
  );

  final GetUpdate _getUpdateUseCase;

  final UpdateApp _updateAppUseCase;

  final DownloadService _downloadService;

  @observable
  ObservableFuture<void> fetchUpdateFuture = ObservableFuture.value({});

  @action
  Future<void> fetchUpdate(String version, String path) async {
    fetchUpdateFuture = ObservableFuture(_getUpdate(version, path));
  }

  @action
  void installUpdate(String path) {
    _updateAppUseCase.call(UpdateAppParams(path: path));
  }

  @observable
  double apkSize = 0;

  @observable
  double currentSize = 0;

  Future<void> _getUpdate(String version, String path) async {
    final response = await _getUpdateUseCase
        .call(GetUpdateParams(version: version, path: path));
    response.fold(
      (error) =>
          throw MobXException(error.message ?? 'Get apk for update failed'),
      (_) => _downloadService.downloadStream.listen(
        (event) {
          if (apkSize != event.total) {
            apkSize = event.total / 1024 / 1024;
          }
          currentSize = event.current / 1024 / 1024;
          debugPrint(event.current.toString());
        },
      ),
    );
  }
}
