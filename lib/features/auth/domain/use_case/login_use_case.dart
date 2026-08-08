import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/login_response_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class LoginUseCase {
  LoginUseCase(this._repo);
  final AuthRepoInterface _repo;

  Future<ResultApi<LoginResponseEntity>> invoke({
    required String password,
    required String email,
  }) async => await _repo.login(email: email, password: password);
}
