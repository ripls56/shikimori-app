import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/use_cases/creditional/get_creditional.dart';
import 'package:shikimoriapp/injection.container.dart' as di;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getCreditional) : super(ProfileEmpty());
  final GetCreditional getCreditional;

  Future<void> getCreditionals() async {
    try {
      final loadedOrFailure = await getCreditional.call(
          GetCreditionalParams(accessToken: di.sl<UserAuth>().accessToken!));
      loadedOrFailure.fold((error) {
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
              });
    } catch (e) {
      emit(ProfileEmpty());
      rethrow;
    }
  }
}
