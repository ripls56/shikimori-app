import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_id.dart';
part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> {
  AnimeDetailCubit(this.getAnimeById) : super(AnimeDetailEmpty());

  final GetAnimeById getAnimeById;

  Future<void> getAnimeDetails(int id) async {
    try {
      emit(AnimeDetailEmpty());
      // await Future.delayed(const Duration(milliseconds: 1000));
      final loadedOrFailure =
          await getAnimeById.call(GetAnimeByIdParams(id: id));
      loadedOrFailure.fold(
        (error) => {
          emit(AnimeDetailEmpty()),
        },
        (loaded) => {
          emit(
            AnimeDetailLoaded(animeDetails: loaded),
          ),
        },
      );
    } catch (ex) {
      emit(AnimeDetailEmpty());
    }
  }
}
