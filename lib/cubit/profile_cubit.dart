import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/models/creditional/creditional.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileEmpty());

  Future<void> getCreditional() async {
    try {
      var apiClient = ApiClient();
      var response = await apiClient.getCreditionals();
      emit(ProfileInitial(response));
    } catch (ex) {
      emit(ProfileEmpty());
    }
  }
}
