import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_animes.dart';
import 'anime_page_state.dart';

class AnimeCubit extends Cubit<AnimePageState> {
  AnimeCubit(this.getAnimes) : super(AnimePageEmpty());
  final GetAnimes getAnimes;
  List<Anime> animes = [];

  Future<void> getAnimeList(int page) async {
    try {
      if (page == 1) {
        emit(AnimePageEmpty());
      } else {
        emit(AnimePageLoading());
      }
      // await Future.delayed(const Duration(milliseconds: 1000));
      final loadedOrFailure = await getAnimes.call(GetAnimesParams(page: page));
      loadedOrFailure.fold(
        (error) => {emit(AnimePageError(errorMessage: error.toString()))},
        (loaded) => {emit(AnimePageLoaded(animeList: loaded)), animes = loaded},
      );
    } catch (_) {
      emit(const AnimePageError(errorMessage: 'error'));
    }
  }
}
