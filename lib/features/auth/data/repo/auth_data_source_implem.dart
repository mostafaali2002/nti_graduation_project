import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/auth/data/model/login_response_dto.dart';
import 'package:nti_graduation_project/features/auth/data/model/register_request_dto.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/login_response_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/repo/auth_data_source_interface.dart';

@Injectable(as: AuthDataSourceInterface)
class AuthDataSourceImplem implements AuthDataSourceInterface {
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request) async {
    try {
      DioHelper.init();
      final registerRequestDto = RegisterRequestDto(
        name: request.name,
        phone: request.phone,
        email: request.email,
        password: request.password,
        confirmPassword: request.confirmPassword,
      );
      final registerResponse = await DioHelper.dio.post(
        ApiConstant.register,
        data: registerRequestDto.toJson(),
      );
      return Success(registerResponse.data["message"]);
    } on DioException catch (e) {
      return Error(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      DioHelper.init();
      final loginResponse = await DioHelper.dio.post(
        ApiConstant.login,
        data: jsonEncode({"email": email, "password": password}),
      );
      final loginResponseDto = LoginResponseDto.fromJson(loginResponse.data);
      return Success(loginResponseDto.toEntity());
    } on DioException catch (e) {
      return Error(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}
