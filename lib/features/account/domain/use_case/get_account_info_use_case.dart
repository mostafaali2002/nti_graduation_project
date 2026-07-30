import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/account/domain/repo/account_repo_interface.dart';
import 'package:nti_graduation_project/features/home/domain/entities/get_account_entity.dart';

@injectable
class GetAccountUseCase {
  final AccountRepoInterface _homeRepoInterface;
  GetAccountUseCase(this._homeRepoInterface);
  Future<ResultApi<GetProfileEntity>> invoke() async =>
      await _homeRepoInterface.getAccountInfo();
}
