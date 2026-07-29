import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';

abstract interface class AccountDataSourceInterface {
  Future<ResultApi<ProfileEntity>> getAccountInfo();
  Future<ResultApi<String>> postAccountInfo(ProfileEntity messageEntity);
}
