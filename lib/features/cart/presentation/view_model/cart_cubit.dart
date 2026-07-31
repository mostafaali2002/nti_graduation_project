import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import '../../../../core/network/result_api.dart';
import '../../../home/domain/entities/all_product_entity.dart';
import '../../domain/use_case/add_cart_use_case.dart';
import '../../domain/use_case/delete_cart_use_case.dart';
import '../../domain/use_case/get_cart_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddCartUseCase addCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addCartUseCase,
    required this.deleteCartUseCase,
  }) : super(CartInitial());

  CartEntity? _currentCart;
  Map<int, int> _quantities = {};

  CartEntity? get currentCart => _currentCart;
  Map<int, int> get quantities => _quantities;

  Future<void> getCart() async {
    emit(GetCartLoading());

    final result = await getCartUseCase();

    switch (result) {
      case Success<CartEntity>():
        _currentCart = result.data;
        _initQuantities();
        emit(GetCartSuccess(_currentCart!, quantities: _quantities));

      case Error<CartEntity>():
        emit(GetCartFailure(result.messageError));
    }
  }

  void _initQuantities() {
    _quantities = {};
    for (var product in _currentCart!.productList) {
      _quantities[product.id] = 1;
    }
  }

  int _getProductStock(int productId) {
    final product = _currentCart?.productList.firstWhere(
      (p) => p.id == productId,
      orElse: () => ProductListEntity(),
    );
    return product?.stock ?? 0;
  }

  Future<void> increaseQuantity(int productId) async {
    final currentQuantity = _quantities[productId] ?? 1;
    final maxStock = _getProductStock(productId);

    if (currentQuantity >= maxStock) {
      emit(
        OutOfStockError(
          'Out of stock! Only $maxStock items available.',
          cart: _currentCart!,
          quantities: _quantities,
        ),
      );
      return;
    }

    final oldQuantity = currentQuantity;
    _quantities[productId] = currentQuantity + 1;

    final result = await addCartUseCase(productId: productId.toString());

    switch (result) {
      case Success<String>():
        emit(UpdateQuantitySuccess(_currentCart!, quantities: _quantities));

      case Error<String>():
        _quantities[productId] = oldQuantity;
        emit(UpdateQuantityFailure(result.messageError));
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    if (!_quantities.containsKey(productId)) return;

    final currentQuantity = _quantities[productId]!;

    if (currentQuantity == 1) {
      await deleteCart(productId.toString());
      return;
    }

    final oldQuantity = currentQuantity;
    _quantities[productId] = currentQuantity - 1;

    final result = await deleteCartUseCase(productId: productId.toString());

    switch (result) {
      case Success<String>():
        emit(UpdateQuantitySuccess(_currentCart!, quantities: _quantities));

      case Error<String>():
        _quantities[productId] = oldQuantity;
        emit(UpdateQuantityFailure(result.messageError));
    }
  }

  Future<void> addCart(String productId) async {
    emit(AddCartLoading());

    final result = await addCartUseCase(productId: productId);

    switch (result) {
      case Success<String>():
        await _refreshCart();
        emit(
          AddCartSuccess(result.data, _currentCart!, quantities: _quantities),
        );

      case Error<String>():
        emit(AddCartFailure(result.messageError));
    }
  }

  Future<void> deleteCart(String productId) async {
    emit(DeleteCartLoading());

    final result = await deleteCartUseCase(productId: productId);

    switch (result) {
      case Success<String>():
        _removeProductFromCart(productId);
        emit(
          DeleteCartSuccess(
            result.data,
            _currentCart!,
            quantities: _quantities,
          ),
        );

      case Error<String>():
        emit(DeleteCartFailure(result.messageError));
    }
  }

  Future<void> _refreshCart() async {
    final result = await getCartUseCase();
    if (result is Success<CartEntity>) {
      _currentCart = result.data;
      _initQuantities();
    }
  }

  void _removeProductFromCart(String productId) {
    if (_currentCart == null) return;

    final productIdInt = int.parse(productId);

    final updatedList = _currentCart!.productList
        .where((product) => product.id != productIdInt)
        .toList();

    _currentCart = CartEntity(productList: updatedList);

    _quantities.remove(productIdInt);
  }

  double calculateTotalPrice() {
    if (_currentCart == null) return 0.0;

    double total = 0.0;
    for (var product in _currentCart!.productList) {
      final quantity = _quantities[product.id] ?? 1;
      total += product.price * quantity;
    }
    return total;
  }
}
