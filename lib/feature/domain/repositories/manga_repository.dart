import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/entities/manga_details/manga_details.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

abstract class MangaRepository {
  ///Get anime list with page
  Future<Either<Failure, List<Manga>>> getMangas(int page,
      {String? order = "ranked", int? limit = 50, int? score});

  ///Get anime details with id
  Future<Either<Failure, MangaDetails>> getMangaById(int id);

  ///Get all screenshot videos by id
  Future<Either<Failure, List<Related>>> getRelatedMangas(int id);
}
