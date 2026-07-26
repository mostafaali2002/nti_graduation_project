import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/data/model/all_product_model/all_product_dto.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_data_source_interface.dart';

class HomeDataSourceImp implements HomeDataSourceInterface {
  @override
  Future<ResultApi<CategoryEntity>> getCategories() {
    throw UnimplementedError();
  }

  @override
  Future<ResultApi<AllProductEntity>> getAllProducts({
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjNjN2I3ZmY4Yzk4YjE2NzcyOTk2YSIsImlhdCI6MTc4NDkyNDEzOSwiZXhwIjoxNzg3NTE2MTM5fQ.KU7CP8RSbNjzEttsOTBdXP1LyCin3iYjo8-EKZe0jZw",
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiConstant.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      final response = await dio.get(
        ApiConstant.allProductEndPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final result = AllProductDto.fromJson(response.data).toEntity();
      return Success(result);
    } on DioException catch (e) {
      return Error(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}
