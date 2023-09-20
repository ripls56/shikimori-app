import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/download/service/download_service.dart';

///Update repository
abstract interface class UpdateRepository {
  ///If exist get application update from api
  Future<Either<Failure, (StreamSubscription<DownloadData>, CancelToken)>>
      getUpdate(
    String currentVersion,
    String path,
  );

  ///Update application with apk file
  Future<Either<Failure, void>> updateApp(String path);
}
