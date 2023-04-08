part of 'character_cubit.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterEmpty extends CharacterState {}

class CharacterError extends CharacterState {
  final String errorMessage;

  const CharacterError({required this.errorMessage});
}

class CharacterLoaded extends CharacterState {
  final Character character;

  const CharacterLoaded({required this.character});
}
