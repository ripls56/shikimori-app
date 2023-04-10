import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_related.dart';
part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> {
  AnimeDetailCubit(this.getAnimeById, this.getRelatedAnimes)
      : super(AnimeDetailEmpty());

  final GetAnimeById getAnimeById;
  final GetRelatedAnimes getRelatedAnimes;

  Future<void> getAnimeDetails(int id) async {
    try {
      emit(AnimeDetailEmpty());
      var related = await _getRelatedAnimes(id);
      final loadedOrFailure =
          await getAnimeById.call(GetAnimeByIdParams(id: id));
      loadedOrFailure.fold(
        (error) => {
          emit(AnimeDetailError(errorMessage: error.toString())),
        },
        (loaded) => {
          emit(
            AnimeDetailLoaded(animeDetails: loaded, related: related),
          ),
        },
      );
    } catch (ex) {
      emit(AnimeDetailError(errorMessage: ex.toString()));
    }
  }

  Future<List<Related>> _getRelatedAnimes(int id) async {
    try {
      List<Related> response = [];
      final loadedOrFailure =
          await getRelatedAnimes.call(GetRelatedParams(id: id));
      loadedOrFailure.fold(
        (error) => throw ServerException(),
        (loaded) => response = loaded,
      );
      return response;
    } catch (ex) {
      throw ServerException();
    }
  }
}
