part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoding extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseEntity loginResponseEntity;

  LoginSuccess(this.loginResponseEntity);
}

class LoginError extends LoginState {
  final String massage;

  LoginError(this.massage);
}
