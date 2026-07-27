import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_data_source_interface.dart';

class FavouriteDataSourceImp implements FavouriteDataSourceInterface {
  @override
  Future<ResultApi<FavoriteEntity>> addFavorite(int productId) async {
    try {
      final response = await DioHelper.dio.post(
        ApiConstant.addToFavourite,
        data: {
          "productId": productId,
        },
        options: _getOptions(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success<FavoriteEntity>(
          FavoriteEntity.fromJson(response.data),
        );
      }

      return Error<FavoriteEntity>(
        response.statusMessage ?? "Failed to add favorite",
      );
    } on DioException catch (e) {
      return Error<FavoriteEntity>(
        DioHelper.handleDioError(e),
      );
    } catch (e) {
      return Error<FavoriteEntity>(
        e.toString(),
      );
    }
  }

  @override
  Future<ResultApi<FavoriteEntity>> deleteFavorite(int productId) async {
    try {
      final response = await DioHelper.dio.delete(
        "${ApiConstant.deleteFavourite}/$productId",
        options: _getOptions(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success<FavoriteEntity>(
          FavoriteEntity.fromJson(response.data),
        );
      }

      return Error<FavoriteEntity>(
        response.statusMessage ?? "Failed to delete favorite",
      );
    } on DioException catch (e) {
      return Error<FavoriteEntity>(
        DioHelper.handleDioError(e),
      );
    } catch (e) {
      return Error<FavoriteEntity>(
        e.toString(),
      );
    }
  }

  @override
  Future<ResultApi<FavoriteEntity>> getfavorite() async {
    try {
      final response = await DioHelper.dio.get(
        ApiConstant.getFavourite,
        options: _getOptions(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success<FavoriteEntity>(
          FavoriteEntity.fromJson(response.data),
        );
      }

      return Error<FavoriteEntity>(
        response.statusMessage ?? "Failed to get favorites",
      );
    } on DioException catch (e) {
      return Error<FavoriteEntity>(
        DioHelper.handleDioError(e),
      );
    } catch (e) {
      return Error<FavoriteEntity>(e.toString());
    }
  }

  Options _getOptions() {
    return Options(
      headers: {
        'Authorization': 'Bearer ${DioHelper.token}',
        'Content-Type': 'application/json',
      },
    );
  }
}