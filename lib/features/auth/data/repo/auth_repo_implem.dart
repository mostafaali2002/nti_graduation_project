import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/constant/app_keys.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/storge_helper/secure_storage_helper.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/login_response_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/repo/auth_data_source_interface.dart';
import 'package:nti_graduation_project/features/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImplem implements AuthRepoInterface {
  AuthRepoImplem(this._dataSource);
  final AuthDataSourceInterface _dataSource;

  @override
  Future<ResultApi<String>> register(RegisterRequestEntity requst) async =>
      await _dataSource.register(requst);

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _dataSource.login(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        var entity = result.data;
        await SecureStorageHelper.instance.saveSecure(
          key: AppKeys.token,
          value: entity.token,
        );
        return Success(entity);
      case Error<LoginResponseEntity>():
        return Error(result.messageError);
    }
  }
}
