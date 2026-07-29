import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class AddFavoriteUseCase {
  final FavoriteRepoInterface _repo;
  AddFavoriteUseCase(this._repo);

  Future<ResultApi<String>> invoke(int productId) async =>
      await _repo.addFavorite(productId: productId.toString());
}