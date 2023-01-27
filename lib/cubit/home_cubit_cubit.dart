// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/cubit/home_cubit_state.dart';
import '../models/anime/anime.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState([]));

  List<Anime> animes = [];

  Future<void> getAnimes(int page) async {
    final apiClient = ApiClient();
    animes = await apiClient.getAnimes(page);
    emit(HomeState(animes));
  }
}
