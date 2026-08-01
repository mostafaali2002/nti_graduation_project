import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoading extends CartState {}

final class GetCartSuccess extends CartState {
  final CartEntity cart;
  final Map<int, int> quantities;
  GetCartSuccess(this.cart, {this.quantities = const {}});
}

final class GetCartFailure extends CartState {
  final String message;
  GetCartFailure(this.message);
}

final class AddCartLoading extends CartState {}

final class AddCartSuccess extends CartState {
  final CartEntity cart;
  final Map<int, int> quantities;

  AddCartSuccess(this.cart, {this.quantities = const {}});
}

final class AddCartFailure extends CartState {
  final String message;
  AddCartFailure(this.message);
}

final class DeleteCartLoading extends CartState {}

final class DeleteCartSuccess extends CartState {
  final CartEntity cart;
  final Map<int, int> quantities;

  DeleteCartSuccess(this.cart, {this.quantities = const {}});
}

final class DeleteCartFailure extends CartState {
  final String message;
  DeleteCartFailure(this.message);
}

final class UpdateQuantityLoading extends CartState {}

final class UpdateQuantitySuccess extends CartState {
  final CartEntity cart;
  final Map<int, int> quantities;
  UpdateQuantitySuccess(this.cart, {this.quantities = const {}});
}

final class UpdateQuantityFailure extends CartState {
  final String message;
  UpdateQuantityFailure(this.message);
}

final class OutOfStockError extends CartState {
  final String message;
  final CartEntity cart;
  final Map<int, int> quantities;

  OutOfStockError(
      this.message, {
        required this.cart,
        this.quantities = const {},
      });
}