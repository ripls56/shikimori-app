import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/api_client.dart';

import '../../feature/data/models/anime/anime.dart';
import 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState([]));

  List<AnimeModel> animes = [];

  Future<void> getAnimes(int page) async {
    final apiClient = ApiClient();
    animes = await apiClient.getAnimes(page);
    emit(HomeState(animes));
  }
}
