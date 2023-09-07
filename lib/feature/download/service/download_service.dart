import 'dart:async';

class DownloadService {
  final _stream = StreamController<DownloadData>();
  Stream<DownloadData> get downloadStream => _stream.stream;

  ///Add [DownloadData] to existing stream
  void addDownloadData(DownloadData data) {
    _stream.sink.add(data);
  }
}

class DownloadData {
  DownloadData(this.current, this.total);

  final int current;
  final int total;
}
