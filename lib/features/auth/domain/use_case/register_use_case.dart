import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class RegisterUseCase {
  RegisterUseCase(this._repo);
  final AuthRepoInterface _repo;

  Future<ResultApi<String>> invoke(RegisterRequestEntity requst) async =>
      await _repo.register(requst);
}
