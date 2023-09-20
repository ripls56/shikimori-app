import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/download/service/download_service.dart';

///Update remote data source
abstract class UpdateRemoteDataSource {
  ///Get update from api
  ///
  ///Throws [ServerException] for all code errors
  Future<(StreamSubscription<DownloadData>, CancelToken)> getUpdate(
    String version,
    String path,
  );
}
