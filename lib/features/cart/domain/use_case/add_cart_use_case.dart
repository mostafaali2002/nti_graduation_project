import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_repo_interface.dart';
import '../../../../core/network/result_api.dart';

@injectable
class AddCartUseCase {
  final CartRepoInterface cartRepo;

  AddCartUseCase({required this.cartRepo});

  Future<ResultApi<String>> call({required String productId}) async {
    return await cartRepo.addCart(productId: productId);
  }
}
