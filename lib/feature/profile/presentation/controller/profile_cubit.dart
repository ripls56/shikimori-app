import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token_from_storage.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_refresh_token_from_storage.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';
import 'package:shikimoriapp/feature/profile/domain/use_cases/get_creditional.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getCreditional, this._getAccessTokenFromStorage,
      this._getRefreshTokenFromStorage)
      : super(ProfileEmpty());
  final GetCreditional _getCreditional;
  final GetAccessTokenFromStorage _getAccessTokenFromStorage;
  final GetRefreshTokenFromStorage _getRefreshTokenFromStorage;

  Future<String> getAccessTokenFromStorage() async {
    try {
      final loadedOrFailure =
          await _getAccessTokenFromStorage.call(const NoParams());
      var token = '';
      loadedOrFailure.fold(
        (error) {
          emit(ProfileEmpty());
        },
        (loaded) => token = loaded,
      );
      return token;
    } catch (e) {
      emit(ProfileEmpty());
      rethrow;
    }
  }
  //
  // Future<String> getRefreshTokenFromStorage() async {
  //   try {
  //     final loadedOrFailure =
  //         await _getRefreshTokenFromStorage.call(const NoParams());
  //     var token = '';
  //     loadedOrFailure.fold(
  //       (error) {
  //         emit(ProfileEmpty());
  //       },
  //       (loaded) => token = loaded,
  //     );
  //     return token;
  //   } catch (e) {
  //     emit(ProfileEmpty());
  //     rethrow;
  //   }
  // }

  Future<void> getCreditionals(String token) async {
    try {
      final loadedOrFailure =
          await _getCreditional.call(GetCreditionalParams(accessToken: token));
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
