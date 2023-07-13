import 'package:dio/dio.dart';
import 'package:shikimoriapp/feature/data/datasources/manga/manga_remote_data_source.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/entities/manga_details/manga_details.dart';

///Manga remote data source implementation
class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  ///Need http client to work
  MangaRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Manga>> getAnimes(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<MangaDetails> getAnimeById(int id) {
    throw UnimplementedError();
  }
}
