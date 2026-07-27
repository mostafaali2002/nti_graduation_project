import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/auth/data/model/register_request_dto.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/repo/auth_data_source_interface.dart';

@Injectable(as: AuthDataSourceInterface)
class AuthDataSourceImplem implements AuthDataSourceInterface {
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request) async {
    try {
      DioHelper.init();
      final dto = RegisterRequestDto(
        name: request.name,
        phone: request.phone,
        email: request.email,
        password: request.password,
        confirmPassword: request.confirmPassword,
      );
      final response = await DioHelper.dio.post(
        ApiConstant.register,
        data: dto.toJson(),
      );
      return Success(response.data["message"]);
    } on DioException catch (e) {
      return Error(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}
