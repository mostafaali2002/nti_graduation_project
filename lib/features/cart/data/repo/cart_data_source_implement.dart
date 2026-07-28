import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/cart/data/model/cart_dto.dart';
import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_data_source_interface.dart';

class CartDataSourceImp implements CartDataSourceInterface {
  @override
  Future<ResultApi<CartEntity>> getCart() async {
    try {
      final Response response = await DioHelper.dio.get(
        ApiConstant.getCartEndPoint,
        options: Options(
          headers: {"Authorization": "Bearer ${DioHelper.token}"},
        ),
      );
      final CartDto cartDto = CartDto.fromJson(response.data);

      final CartEntity cartEntity = cartDto.toEntity();

      return Success(cartEntity);
    } on DioException catch (e) {
      return Error(e.response?.data["message"] ?? e.message ?? "Unknown Error");
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> addCart({required String productId}) async {
    try {
      final Response response = await DioHelper.dio.post(
        ApiConstant.addCartEndPoint,
        data: {"productId": productId},
        options: Options(
          headers: {"Authorization": "Bearer ${DioHelper.token}"},
        ),
      );

      return Success(response.data["message"] ?? "Added to cart successfully");
    } on DioException catch (e) {
      return Error(e.response?.data["message"] ?? e.message ?? "Unknown Error");
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> deleteCart({required String productId}) async {
    try {
      final Response response = await DioHelper.dio.delete(
        ApiConstant.deleteCartEndPoint,
        data: {"productId": productId},
        options: Options(
          headers: {"Authorization": "Bearer ${DioHelper.token}"},
        ),
      );

      return Success(
        response.data["message"] ?? "Removed from cart successfully",
      );
    } on DioException catch (e) {
      return Error(e.response?.data["message"] ?? e.message ?? "Unknown Error");
    } catch (e) {
      return Error(e.toString());
    }
  }
}
