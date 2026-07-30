import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/home/data/model/all_product_model/all_product_dto.dart';
import 'package:nti_graduation_project/features/home/data/model/category_model/category_dto.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_data_source_interface.dart';

class HomeDataSourceImp implements HomeDataSourceInterface {
  @override
  Future<ResultApi<CategoryEntity>> getCategories() async {
    try {
      DioHelper.init();
      final response = await DioHelper.dio.get(
        ApiConstant.categoriesEndPoint,
        options: Options(
          headers: {'Authorization': 'Bearer ${DioHelper.token}'},
        ),
      );
      final result = CategoryDto.fromJson(response.data).toEntity();
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
  Future<ResultApi<AllProductEntity>> getAllProducts() async {
    try {
      DioHelper.init();
      final response = await DioHelper.dio.get(
        ApiConstant.allProductEndPoint,
        options: Options(
          headers: {'Authorization': 'Bearer ${DioHelper.token}'},
        ),
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

  @override
  Future<ResultApi<AllProductEntity>> getProductsByCategory({
    required String slug,
    int skip = 0,
    int limit = 5,
  }) async {
    try {
      DioHelper.init();
      final response = await DioHelper.dio.get(
        ApiConstant.productsByCategoryEndPoint(slug),
        queryParameters: {'skip': skip, 'limit': limit},
        options: Options(
          headers: {'Authorization': 'Bearer ${DioHelper.token}'},
        ),
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
