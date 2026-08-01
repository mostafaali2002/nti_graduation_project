import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_repo_interface.dart';
import '../../../../core/network/result_api.dart';

@injectable
class GetCartUseCase {
  final CartRepoInterface cartRepo;

  GetCartUseCase({required this.cartRepo});

  Future<ResultApi<CartEntity>> call() async {
    return await cartRepo.getCart();
  }
}
