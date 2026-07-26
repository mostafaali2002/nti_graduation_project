part of 'get_all_product_cubit.dart';

sealed class GetAllProductState {}

final class GetAllProductInitial extends GetAllProductState {}

final class GetAllProductLoading extends GetAllProductState {}

final class GetAllProductSuccess extends GetAllProductState {
  List<ProductListEntity> list;
  GetAllProductSuccess(this.list);
}

final class GetAllProductFailure extends GetAllProductState {
  final String errorMessage;
  GetAllProductFailure(this.errorMessage);
}
