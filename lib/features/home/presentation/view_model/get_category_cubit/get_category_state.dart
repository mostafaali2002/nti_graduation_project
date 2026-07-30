// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_category_cubit.dart';

sealed class GetCategoryState {}

class GetCategoryInitial extends GetCategoryState {}

class GetCategoryLoading extends GetCategoryState {}

class GetCategorySuccess extends GetCategoryState {
  List<CategoryListEntity> categories;
  GetCategorySuccess(this.categories);
}

class GetCategoryFailure extends GetCategoryState {
  final String errorMessage;
  GetCategoryFailure(this.errorMessage);
}
