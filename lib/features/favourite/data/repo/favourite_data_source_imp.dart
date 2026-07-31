import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/favourite/data/model/favorite_dto.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_data_source_interface.dart';
@Injectable(as:FavoriteDataSourceInterface)
class FavoriteDataSourceImp implements FavoriteDataSourceInterface {
  @override
  Future<ResultApi<FavoriteEntity>> getFavorite() async {
    try {
      final Response response = await DioHelper.dio.get(
        ApiConstant.getFavourite,
        
      );
      final FavoriteDto favoriteDto = FavoriteDto.fromJson(response.data);
      final FavoriteEntity favoriteEntity = favoriteDto.toEntity();

      return Success(favoriteEntity);
    } on DioException catch (e) {
      return Error(e.response?.data["message"] ?? e.message ?? "Unknown Error");
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> addFavorite({required String productId}) async {
    try {
      final Response response = await DioHelper.dio.post(
        ApiConstant.addToFavourite,
        data: {"productId": productId},
      
      );

      return Success(response.data["message"] ?? "Added to cart successfully");
    } on DioException catch (e) {
      return Error(e.response?.data["message"] ?? e.message ?? "Unknown Error");
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> deleteFavorite({required String productId}) async {
    try {
      final Response response = await DioHelper.dio.delete(
        ApiConstant.deleteFavourite,
        data: {"productId": productId},
       
        
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
