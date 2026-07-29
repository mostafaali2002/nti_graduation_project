import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/account/domain/repo/account_repo_interface.dart';
import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';

class GetAccountUseCase {
  final AccountRepoInterface _homeRepoInterface;
  GetAccountUseCase(this._homeRepoInterface);
  Future<ResultApi<ProfileEntity>> invoke() async =>
      await _homeRepoInterface.getAccountInfo();
}
