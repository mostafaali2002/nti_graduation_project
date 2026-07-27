import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart';

class FavouriteRepoImp implements FavouriteRepoInterface {
  final FavouriteDataSourceInterface _dataSource;

  FavouriteRepoImp(this._dataSource);

  @override
  Future<ResultApi<FavoriteEntity>> addFavorite(int productId) async =>
      await _dataSource.addFavorite(productId);

  @override
  Future<ResultApi<FavoriteEntity>> deleteFavorite(int productId) async =>
      await _dataSource.deleteFavorite(productId);

  @override
  Future<ResultApi<FavoriteEntity>> getfavorite() async =>
      await _dataSource.getfavorite();
}
