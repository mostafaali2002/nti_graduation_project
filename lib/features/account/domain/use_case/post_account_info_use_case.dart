import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/account/domain/repo/account_repo_interface.dart';
import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';

@injectable
class PostAccountInfoUseCase {
  final AccountRepoInterface _accountRepoInterface;
  PostAccountInfoUseCase(this._accountRepoInterface);
  Future<ResultApi<String>> invoke(ProfileEntity messageEntity) async =>
      await _accountRepoInterface.postAccountInfo(messageEntity);
}
