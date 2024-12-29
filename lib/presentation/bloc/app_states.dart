abstract class AppStates {}

class AppInitialState extends AppStates {}

class LoginLoadingState extends AppStates {}

class LoginSuccessState extends AppStates {}

class LoginErrorState extends AppStates {
  final String error;

  LoginErrorState(this.error);
}