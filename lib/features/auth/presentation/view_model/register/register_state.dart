part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoding extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterErorr extends RegisterState {
  final String massage;

  RegisterErorr(this.massage);
}
