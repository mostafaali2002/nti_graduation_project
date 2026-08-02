import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/account/domain/entities/account_entity.dart';
import 'package:nti_graduation_project/features/account/domain/entities/get_account_entity.dart';

abstract interface class AccountDataSourceInterface {
  Future<ResultApi<GetProfileEntity>> getAccountInfo();
  Future<ResultApi<String>> postAccountInfo(ProfileEntity messageEntity);
}
