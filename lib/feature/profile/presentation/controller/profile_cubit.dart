import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';
import 'package:shikimoriapp/feature/profile/domain/use_cases/get_credential.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getCredential) : super(ProfileEmpty());
  final GetCredential _getCredential;

  Future<void> getCredentials(String token) async {
    try {
      final loadedOrFailure =
          await _getCredential.call(GetCredentialParams(accessToken: token));
      loadedOrFailure.fold(
        (error) {
          if (error is AuthFailure) {
            emit(
              ProfileTokenException(),
            );
          } else {
            emit(ProfileEmpty());
          }
        },
        (loaded) => {
          emit(ProfileInitial(loaded)),
        },
      );
    } catch (e) {
      emit(ProfileEmpty());
      rethrow;
    }
  }

  Future<void> logout() async {}
}
