import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';

abstract class FavoriteRepoInterface {
  Future<ResultApi<FavoriteEntity>> getFavorite();

  Future<ResultApi<String>> addFavorite({
    required String productId,
  });

  Future<ResultApi<String>> deleteFavorite({
    required String productId,
  });
}