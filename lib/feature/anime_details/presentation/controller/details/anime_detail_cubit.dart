import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_related.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> {
  AnimeDetailCubit(this.getAnimeById, this.getRelatedAnimes)
      : super(AnimeDetailEmpty());

  final GetAnimeById getAnimeById;
  final GetRelatedAnimes getRelatedAnimes;

  Future<void> getAnimeDetails(int id) async {
    try {
      emit(AnimeDetailEmpty());
      final related = await _getRelatedAnimes(id);
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
      rethrow;
    }
  }

  Future<List<Related>> _getRelatedAnimes(int id) async {
    try {
      var response = <Related>[];
      final loadedOrFailure =
          await getRelatedAnimes.call(GetRelatedParams(id: id));
      loadedOrFailure.fold(
        (error) => throw ServerException(),
        (loaded) => response = loaded,
      );
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
