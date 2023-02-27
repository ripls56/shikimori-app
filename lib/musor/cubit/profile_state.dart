part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {
  final CreditionalModel creditional;

  ProfileInitial(this.creditional);
}

class ProfileEmpty extends ProfileState {}
