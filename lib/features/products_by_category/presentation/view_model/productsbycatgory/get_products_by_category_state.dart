part of 'get_products_by_category_cubit.dart';

sealed class GetProductsByCategoryState {}

final class GetProductsByCategoryInitial extends GetProductsByCategoryState {}

final class GetProductsByCategoryLoading extends GetProductsByCategoryState {}

final class GetProductsByCategorySuccess extends GetProductsByCategoryState {
  List<ProductListEntity> list;
  GetProductsByCategorySuccess(this.list);
}

final class GetProductsByCategoryFailure extends GetProductsByCategoryState {
  final String errorMessage;
  GetProductsByCategoryFailure(this.errorMessage);
}
