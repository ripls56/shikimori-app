import 'package:dio/dio.dart';
import 'package:shikimoriapp/feature/domain/entities/manga_details/manga_details.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'manga_remote_data_source.dart';

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  final Dio dio;
  MangaRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Manga>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score}) {
    throw UnimplementedError();
  }

  @override
  Future<MangaDetails> getAnimeById(int id) {
    throw UnimplementedError();
  }
}
