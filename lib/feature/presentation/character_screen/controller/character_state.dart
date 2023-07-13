part of 'character_cubit.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterEmpty extends CharacterState {}

class CharacterError extends CharacterState {

  const CharacterError({required this.errorMessage});
  final String errorMessage;
}

class CharacterLoaded extends CharacterState {

  const CharacterLoaded({required this.character});
  final Character character;
}
