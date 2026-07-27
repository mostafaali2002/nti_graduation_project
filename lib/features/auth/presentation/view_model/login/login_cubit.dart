import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/login_response_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/use_case/login_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());
  final LoginUseCase _loginUseCase;
  Future<void> intent(LoginIntint intint) async {
    switch (intint) {
      case LoginIntintLogin():
        _login(intint.email, intint.password);
    }
  }

  Future<void> _login(String email, String password) async {
    emit(LoginLoding());
    final result = await _loginUseCase.invoke(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        emit(LoginSuccess(result.data));
      case Error<LoginResponseEntity>():
        emit(LoginError(result.messageError));
    }
  }
}

sealed class LoginIntint {}

class LoginIntintLogin extends LoginIntint {
  LoginIntintLogin({required this.email, required this.password});
  final String email;
  final String password;
}
