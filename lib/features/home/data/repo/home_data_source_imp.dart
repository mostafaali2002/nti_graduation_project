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
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<ResultApi<AllProductEntity>> getAllProducts({String? token}) async {
    try {
      final Dio _dio = Dio();
      var response = await _dio.get(
        '${ApiConstant.baseUrl}${ApiConstant.allProductEndPoint}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      switch (response) {
        case Success<AllProductEntity>():
          var result = AllProductDto.fromJson(response.data).toEntity();
          return Success<AllProductEntity>(result);
        case Error<AllProductEntity>():
          return Error<AllProductEntity>("no internet connection");
      }
      return Error<AllProductEntity>("no internet connection");
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
