import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/anime/domain/use_cases/get_animes.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_state.dart';

///Cubit for [AnimePage]
class AnimePageCubit extends Cubit<AnimePageState> {
  ///
  AnimePageCubit(this._getAnimes) : super(AnimePageEmpty());
  final GetAnimes _getAnimes;

  ///Get anime list
  Future<void> getAnimeList(int page, {String? order = 'ranked'}) async {
    try {
      if (page == 1) {
        emit(AnimePageEmpty());
      } else {
        emit(AnimePageLoading());
      }
      // await Future.delayed(const Duration(milliseconds: 1000));
      final loadedOrFailure =
          await _getAnimes.call(GetAnimesParams(page: page, order: order));
      loadedOrFailure.fold(
        (error) => {emit(AnimePageError(errorMessage: error.toString()))},
        (loaded) => {emit(AnimePageLoaded(animeList: loaded))},
      );
    } catch (_) {
      emit(const AnimePageError(errorMessage: 'error'));
      rethrow;
    }
  }
}
