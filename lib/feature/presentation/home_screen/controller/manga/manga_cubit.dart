import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/use_cases/manga/get_mangas.dart';

part 'manga_state.dart';

class MangaPageCubit extends Cubit<MangaPageState> {
  final GetMangas getMangas;
  MangaPageCubit(this.getMangas) : super(MangaPageEmpty());

  Future<void> getAllMangas(int page) async {
    try {
      if (page == 1) {
        emit(MangaPageEmpty());
      } else {
        emit(MangaPageLoading());
      }
      // await Future.delayed(const Duration(milliseconds: 1000));
      final loadedOrFailure = await getMangas.call(GetMangasParams(page: page));
      loadedOrFailure.fold(
        (error) => {emit(MangaPageError(errorMessage: error.toString()))},
        (loaded) => {emit(MangaPageLoaded(mangaList: loaded))},
      );
    } catch (_) {
      emit(const MangaPageError(errorMessage: 'error'));
    }
  }
}
