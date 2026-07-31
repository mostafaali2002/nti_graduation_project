import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart';
@injectable
class DeleteFavoriteUseCase {
  final FavoriteRepoInterface favoriteRepo;

  DeleteFavoriteUseCase({required this.favoriteRepo});

  Future<ResultApi<String>> invoke(int productId) async =>
      await favoriteRepo.deleteFavorite(productId: productId.toString());
}