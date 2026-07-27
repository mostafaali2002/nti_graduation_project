import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart';

class AddFavoriteUseCase {
  final FavouriteRepoInterface _repo;
  AddFavoriteUseCase(this._repo);

  Future<ResultApi<FavoriteEntity>> invoke(int productId) async =>
      await _repo.addFavorite(productId);
}