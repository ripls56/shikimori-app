import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/api_client.dart';
import 'package:shikimoriapp/feature/data/models/anime_details/anime_details.dart';
part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> {
  AnimeDetailCubit() : super(AnimeDetailEmpty());

  Future<void> getAnimeById(int id) async {
    try {
      var apiClient = ApiClient();
      var response = await apiClient.getAnimeById(id);
      emit(AnimeDetailInitial(response));
    } catch (ex) {
      emit(AnimeDetailEmpty());
    }
  }
}
