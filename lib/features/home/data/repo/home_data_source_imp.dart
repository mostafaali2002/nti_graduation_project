import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
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
}
