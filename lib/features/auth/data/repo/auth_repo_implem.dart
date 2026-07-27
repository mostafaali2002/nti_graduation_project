import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
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
}
