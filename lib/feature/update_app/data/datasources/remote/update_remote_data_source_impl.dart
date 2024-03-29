import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/download/service/download_service.dart';
import 'package:shikimoriapp/feature/update_app/data/datasources/remote/update_remote_data_source.dart';

///Update remote data source implementation
class UpdateRemoteDataSourceImpl implements UpdateRemoteDataSource {
  ///Need dio client to work
  UpdateRemoteDataSourceImpl(this._dio, this._downloadService);

  final Dio _dio;

  final DownloadService _downloadService;

  @override
  Future<(StreamSubscription<DownloadData>, CancelToken)> getUpdate(
    String version,
    String path,
  ) async {
    final (stream, cancelToken) =
        _downloadService.createStreamWithCancelToken();
    unawaited(
      _dio.download(
        ApiEndpoints.update(version),
        path,
        cancelToken: cancelToken,
        onReceiveProgress: (count, total) {
          if (count != -1) {
            stream.sink.add(DownloadData(count, total));
          }
        },
      ),
    );
    return (stream.stream.listen((event) {}), cancelToken);
  }

  @override
  Future<String> getUpdateInformation() async {
    final response = await _dio.get(ApiEndpoints.updateInformation);
    if (response.statusCode == 200) {
      return (response.data as Map<String, dynamic>)['message'] as String;
    } else {
      throw ServerException(
        message: 'Exception in [UpdateRemoteDataSource], '
            'method: getUpdateInformation',
      );
    }
  }
}
