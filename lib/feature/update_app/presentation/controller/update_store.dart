import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/get_update.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/get_update_information.dart';
import 'package:shikimoriapp/feature/update_app/domain/use_cases/update.dart';

part 'update_store.g.dart';

class UpdateStore = _UpdateStoreBase with _$UpdateStore;

abstract class _UpdateStoreBase with Store {
  _UpdateStoreBase(
    this._getUpdateUseCase,
    this._updateAppUseCase,
    this._getUpdateInformationUseCase,
  );

  final GetUpdate _getUpdateUseCase;

  final GetUpdateInformation _getUpdateInformationUseCase;

  final UpdateApp _updateAppUseCase;

  @observable
  ObservableFuture<void> updateFuture = ObservableFuture.value({});

  @observable
  ObservableFuture<void> updateInformationFuture = ObservableFuture.value({});

  @action
  Future<void> fetchUpdate(String version, String path) async {
    updateFuture = ObservableFuture(_getUpdate(version, path));
  }

  @action
  Future<void> fetchUpdateInformation() async {
    updateInformationFuture = ObservableFuture(_getUpdateInformation());
  }

  @action
  void updateApp(String path) {
    _updateAppUseCase.call(UpdateAppParams(path: path));
  }

  @observable
  double apkSize = 0;

  @observable
  double currentSize = 0;

  @observable
  String information = '';

  CancelToken? cancelToken;

  bool checkApkExist(String path) {
    return File(path).existsSync();
  }

  Future<void> _getUpdate(String version, String path) async {
    debugPrint(path);
    final response = await _getUpdateUseCase.call(
      GetUpdateParams(version: version, path: path),
    );
    response.fold(
      (error) =>
          throw MobXException(error.message ?? 'Get apk for update failed'),
      (data) {
        final subscription = data.$1;
        cancelToken = data.$2;
        subscription.onData((data) {
          if (apkSize == currentSize) {
            updateApp(path);
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

  Future<void> _getUpdateInformation() async {
    final response = await _getUpdateInformationUseCase.call(
      const NoParams(),
    );
    response.fold(
      (error) => throw MobXException('Exception in get update information'),
      (data) => information = data,
    );
  }
}
