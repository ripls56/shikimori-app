// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/cubit/home_cubit_state.dart';
import 'package:shikimori_app/models/user_rate.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState([]));

  List<UserRate> rates = [];

  Future<void> getRateList(int id) async {
    final apiClient = ApiClient();
    rates = await apiClient.getAnimeRateList(id);
    emit(HomeState(rates));
  }
}
