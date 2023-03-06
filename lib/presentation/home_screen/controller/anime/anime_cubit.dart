import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/data/models/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_animes.dart';
import 'anime_page_state.dart';

class AnimeCubit extends Cubit<AnimePageState> {
  AnimeCubit(this.getAnimes) : super(AnimePageEmpty());
  final GetAnimes getAnimes;
  List<AnimeModel> animes = [];

  Future<void> getAnimeList(int page) async {
    try {
      emit(AnimePageEmpty());
      await Future.delayed(const Duration(seconds: 3));
      final loadedOrFailure = await getAnimes.call(GetAnimesParams(page: page));
      loadedOrFailure.fold(
        (error) => {emit(const AnimePageError(errorMessage: 'error'))},
        (loaded) => {emit(AnimePageLoaded(animeList: loaded))},
      );
    } catch (_) {
      emit(const AnimePageError(errorMessage: 'error'));
    }
  }
}
