import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_login/presentation/bloc/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  void login(String username, String password) {
    emit(LoginLoadingState());

    Future.delayed(const Duration(seconds: 2), () {
      if (username == 'Admin' && password == 'Admin') {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('Invalid username or password!'));
      }
    });
  }
}