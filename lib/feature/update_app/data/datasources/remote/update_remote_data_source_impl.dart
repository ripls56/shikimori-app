import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/feature/download/service/download_service.dart';
import 'package:shikimoriapp/feature/update_app/data/datasources/remote/update_remote_data_source.dart';

///Update remote data source implementation
class UpdateRemoteDataSourceImpl implements UpdateRemoteDataSource {
  ///Need dio client to work
  UpdateRemoteDataSourceImpl(this._dio, this._downloadService);

  final Dio _dio;

  final DownloadService _downloadService;

  @override
  Future<void> getUpdate(String version, String path) async {
    unawaited(
      _dio.download(
        ApiEndpoints.getUpdate(version),
        path,
        onReceiveProgress: (count, total) {
          if (count != -1) {
            _downloadService.addDownloadData(DownloadData(count, total));
          }
        },
      ),
    );
  }
}
