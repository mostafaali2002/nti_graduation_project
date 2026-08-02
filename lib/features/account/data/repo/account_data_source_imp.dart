import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/account/data/model/account_dto.dart';
import 'package:nti_graduation_project/features/account/data/model/get_account_dto.dart';
import 'package:nti_graduation_project/features/account/domain/repo/account_data_source_interface.dart';
import 'package:nti_graduation_project/features/account/domain/entities/account_entity.dart';
import 'package:nti_graduation_project/features/account/domain/entities/get_account_entity.dart';

@Injectable(as: AccountDataSourceInterface)
class AccountDataSourceImp implements AccountDataSourceInterface {
  @override
  Future<ResultApi<GetProfileEntity>> getAccountInfo() async {
    try {
      final response = await DioHelper.dio.get(
        ApiConstant.accountEndPointGet,
        options: Options(
          headers: {'Authorization': 'Bearer ${DioHelper.token}'},
        ),
      );
      final result = GetProfileDto.fromJson(response.data).toEntity();
      return Success(result);
    } on DioException catch (e) {
      return Error(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> postAccountInfo(ProfileEntity profileEntity) async {
    final messageDto = ProfileDto(
      email: profileEntity.email,
      image: profileEntity.image,
      name: profileEntity.name,
      phone: profileEntity.phone,
      address: profileEntity.address,
    );
    try {
      final response = await DioHelper.dio.post(
        data: messageDto.toJson(),
        ApiConstant.accountEndPointPost,
        options: Options(
          headers: {'Authorization': 'Bearer ${DioHelper.token}'},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Success(jsonEncode(['message']));
      } else {
        return Error(jsonEncode(['message']));
      }
    } on DioException catch (e) {
      return Error(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}
