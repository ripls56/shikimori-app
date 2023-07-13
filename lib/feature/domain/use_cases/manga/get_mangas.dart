import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/repositories/manga_repository.dart';

class GetMangas extends UseCase<List<Manga>, GetMangasParams> {

  GetMangas(this.mangaRepository);
  final MangaRepository mangaRepository;

  @override
  Future<Either<Failure, List<Manga>>> call(GetMangasParams params) async {
    return await mangaRepository.getMangas(params
        .page,); //order: params.order, limit: params.limit, score: params.score
  }
}

class GetMangasParams extends Equatable {

  const GetMangasParams({
    required this.page, this.order,
    this.limit,
    this.score,
  });
  final int page;
  final String? order;
  final int? limit;
  final int? score;

  @override
  List<Object?> get props => [page, order, limit, score];
}
