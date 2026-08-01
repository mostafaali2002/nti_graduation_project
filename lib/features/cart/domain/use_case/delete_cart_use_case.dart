import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_repo_interface.dart';
import '../../../../core/network/result_api.dart';

@injectable
class DeleteCartUseCase {
  final CartRepoInterface cartRepo;

  DeleteCartUseCase({required this.cartRepo});

  Future<ResultApi<String>> call({required String productId}) async {
    return await cartRepo.deleteCart(productId: productId);
  }
}
