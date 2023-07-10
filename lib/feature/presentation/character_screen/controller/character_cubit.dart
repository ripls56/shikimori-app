import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart';
import 'package:shikimoriapp/feature/domain/use_cases/character/get_character_by_id.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this.getCharacterById) : super(CharacterEmpty());

  final GetCharacterById getCharacterById;

  Future<void> getCharacter(int id) async {
    try {
      emit(CharacterEmpty());
      final loadedOrFailure =
          await getCharacterById.call(GetCharacterByIdParams(id: id));
      loadedOrFailure.fold(
        (error) => {emit(CharacterError(errorMessage: error.toString()))},
        (loaded) => {emit(CharacterLoaded(character: loaded))},
      );
    } catch (e) {
      emit(CharacterError(errorMessage: e.toString()));
      rethrow;
    }
  }
}
