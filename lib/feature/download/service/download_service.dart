import 'dart:async';

import 'package:dio/dio.dart';

class DownloadService {
  ///Create stream and token to manage download for  for [DownloadData]
  (StreamController<DownloadData>, CancelToken) createStreamWithCancelToken() {
    return (StreamController<DownloadData>(), CancelToken());
  }
}

class DownloadData {
  DownloadData(this.current, this.total);

  final int current;
  final int total;
}
