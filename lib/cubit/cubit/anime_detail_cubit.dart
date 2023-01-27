import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/models/anime%20details/anime_details.dart';

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
