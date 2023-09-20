import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/get_update.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/update.dart';

part 'update_store.g.dart';

class UpdateStore = _UpdateStoreBase with _$UpdateStore;

abstract class _UpdateStoreBase with Store {
  _UpdateStoreBase(
    this._getUpdateUseCase,
    this._updateAppUseCase,
  );

  final GetUpdate _getUpdateUseCase;

  final UpdateApp _updateAppUseCase;

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

  CancelToken? cancelToken;

  Future<void> _getUpdate(String version, String path) async {
    debugPrint(path);
    final response = await _getUpdateUseCase
        .call(GetUpdateParams(version: version, path: path));
    response.fold(
      (error) =>
          throw MobXException(error.message ?? 'Get apk for update failed'),
      (data) {
        final subscription = data.$1;
        cancelToken = data.$2;
        subscription.onData((data) {
          if (apkSize == data.current) {
            subscription.cancel();
          }
          if (apkSize != data.total) {
            apkSize = data.total / 1024 / 1024;
          }
          currentSize = data.current / 1024 / 1024;
        });
      },
    );
  }
}
