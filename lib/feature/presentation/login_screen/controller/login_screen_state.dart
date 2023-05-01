part of 'login_screen_cubit.dart';

abstract class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginScreenEmpty extends LoginScreenState {}

class LoginScreenLoaded extends LoginScreenState {}
