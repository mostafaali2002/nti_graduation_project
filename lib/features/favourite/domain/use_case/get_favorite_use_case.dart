import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart';

class GetFavoriteUseCase {
  FavouriteRepoInterface _repo;
  GetFavoriteUseCase(this._repo);
   Future<ResultApi<FavoriteEntity>>invoke()async =>await _repo.getfavorite();

}