import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_name.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._getAnimeByName) : super(SearchEmpty());

  final GetAnimeByName _getAnimeByName;

  Future<void> searchAnimeAndManga(String name) async {
    try {
      emit(SearchLoading());
      List<Anime> animes = [];
      List<Manga> mangas = [];
      final loadedOrFailure = await _getAnimeByName
          .call(GetAnimesByNameParams(phrase: name, limit: 50));
      loadedOrFailure.fold(
        (error) => {
          emit(SearchError(errorMessage: error.toString())),
        },
        (loaded) => animes = loaded,
      );
      emit(SearchLoaded(animes: animes, mangas: mangas));
    } catch (ex) {
      emit(SearchError(errorMessage: ex.toString()));
    }
  }

  void emitEmpty() {
    emit(SearchEmpty());
  }
}
