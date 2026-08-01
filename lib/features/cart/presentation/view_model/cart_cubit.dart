import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import '../../../../core/network/result_api.dart';
import '../../../home/domain/entities/all_product_entity.dart';
import '../../domain/use_case/add_cart_use_case.dart';
import '../../domain/use_case/delete_cart_use_case.dart';
import '../../domain/use_case/get_cart_use_case.dart';
import 'cart_state.dart';

@injectable
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

  String? _lastMessage;
  String? _lastProductName;
  bool _isSuccess = false;
  bool _snackBarShown = false;

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
        await getCart();
        emit(UpdateQuantitySuccess(_currentCart!, quantities: _quantities));

      case Error<String>():
        _quantities[productId] = oldQuantity;
        emit(UpdateQuantityFailure(result.messageError));
    }
  }

  Future<void> addCart(String productId, {String? productName}) async {
    _lastProductName = productName;
    _snackBarShown = false;
    emit(AddCartLoading());

    final result = await addCartUseCase(productId: productId);

    switch (result) {
      case Success<String>():
        _lastMessage = result.data;
        _isSuccess = true;

        final cartResult = await getCartUseCase();

        if (cartResult is Success<CartEntity>) {
          _currentCart = cartResult.data;

          final productIdInt = int.parse(productId);

          if (!_quantities.containsKey(productIdInt)) {
            _quantities[productIdInt] = 1;
          }
        }

        emit(AddCartSuccess(_currentCart!, quantities: _quantities));

      case Error<String>():
        _isSuccess = false;
        emit(AddCartFailure(result.messageError));
    }
  }

  Future<void> deleteCart(String productId, {String? productName}) async {
    emit(DeleteCartLoading());

    _lastProductName = productName;
    _snackBarShown = false;

    final result = await deleteCartUseCase(productId: productId);

    switch (result) {
      case Success<String>():
        _lastMessage = result.data;
        _isSuccess = true;

        _removeProductFromCart(productId);
        emit(DeleteCartSuccess(_currentCart!, quantities: _quantities));

      case Error<String>():
        _isSuccess = false;
        emit(DeleteCartFailure(result.messageError));
    }
  }

  Future<void> toggleCart(int productId, {String? productName}) async {
    final isInCart =
        _currentCart?.productList.any((p) => p.id == productId) ?? false;

    if (isInCart) {
      await deleteCart(productId.toString(), productName: productName);
    } else {
      await addCart(productId.toString(), productName: productName);
    }
  }

  void showSnackBar(BuildContext context) {
    if (_snackBarShown) return;

    if (_lastMessage != null) {
      _snackBarShown = true;

      String displayMessage = _lastMessage!;

      if (_lastProductName != null && _lastProductName!.isNotEmpty) {
        displayMessage = '$_lastProductName $_lastMessage';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(displayMessage),
          backgroundColor: _isSuccess ? Colors.green : Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> refreshCart() async {
    final result = await getCartUseCase();
    if (result is Success<CartEntity>) {
      _currentCart = result.data;
      _initQuantities();
    }
  }

  bool isProductInCart(int productId) {
    if (_currentCart == null) return false;
    return _currentCart!.productList.any((p) => p.id == productId);
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

      final priceAfterDiscount =
          (product.price * (1 - product.discountPercentage / 100))
              .floorToDouble();

      total += priceAfterDiscount * quantity;
    }
    return total;
  }
}
