part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {
  ProfileInitial(this.credential);

  final Credential credential;
}

class ProfileEmpty extends ProfileState {}

class ProfileTokenException extends ProfileState {}
