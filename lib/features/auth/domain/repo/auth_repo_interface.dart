import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/login_response_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';

abstract interface class AuthRepoInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity requst);
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  });
}
