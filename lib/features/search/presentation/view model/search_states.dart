import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductListEntity> products;
  SearchSuccess(this.products);
}

final class SearchEmpty extends SearchState {}

final class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);
}