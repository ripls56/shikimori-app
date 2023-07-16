import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/domain/use_cases/get_anime_by_name.dart';

part 'search_event.dart';
part 'search_state.dart';

///Search bloc
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ///[SearchBloc] constructor
  SearchBloc(this._getAnimeByName) : super(SearchEmpty()) {
    on<SearchAnimeEvent>(
      (event, emit) async {
        await _animeSearch(event, emit);
      },
      transformer: (events, mapper) => droppable<SearchAnimeEvent>().call(
        events.debounceTime(
          const Duration(seconds: 2),
        ),
        mapper,
      ),
    );
  }

  final GetAnimeByName _getAnimeByName;

  String _previousQuery = 'query';

  Future<void> _animeSearch(SearchAnimeEvent event, Emitter emit) async {
    try {
      if (event.query == _previousQuery) return;
      emit(SearchEmpty());
      var animes = <Anime>[];
      final loadedOrFailure = await _getAnimeByName
          .call(GetAnimesByNameParams(phrase: event.query, limit: 50));
      loadedOrFailure.fold(
        (error) => {
          emit(SearchError(errorMessage: error.toString())),
        },
        (loaded) {
          animes = loaded;
          _previousQuery = event.query;
        },
      );
      emit(
        SearchLoaded(
          animes: animes,
        ),
      );
    } catch (ex) {
      emit(SearchError(errorMessage: ex.toString()));
    }
  }
}
