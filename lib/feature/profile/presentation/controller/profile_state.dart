part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {

  ProfileInitial(this.creditional);
  final Creditional creditional;
}

class ProfileEmpty extends ProfileState {}

class ProfileTokenException extends ProfileState {}
