import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/login_response_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
}
