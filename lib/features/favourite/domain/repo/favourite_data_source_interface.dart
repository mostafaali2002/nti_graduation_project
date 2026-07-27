import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';

abstract interface class FavouriteDataSourceInterface {
  Future<ResultApi<FavoriteEntity>>getfavorite();
  Future<ResultApi<FavoriteEntity>>addFavorite(int productId);
  Future<ResultApi<FavoriteEntity>>deleteFavorite(int productId);






}