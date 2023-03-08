import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());
}
