import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/account/domain/repo/account_data_source_interface.dart';
import 'package:nti_graduation_project/features/account/domain/repo/account_repo_interface.dart';
import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/get_account_entity.dart';

@Injectable(as: AccountRepoInterface)
class AccountRepoImp implements AccountRepoInterface {
  final AccountDataSourceInterface _accountDataSourceInterface;
  AccountRepoImp(this._accountDataSourceInterface);
  @override
  Future<ResultApi<GetProfileEntity>> getAccountInfo() async =>
      await _accountDataSourceInterface.getAccountInfo();

  @override
  Future<ResultApi<String>> postAccountInfo(
    ProfileEntity messageEntity,
  ) async => await _accountDataSourceInterface.postAccountInfo(messageEntity);
}
