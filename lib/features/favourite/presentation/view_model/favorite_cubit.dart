import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/use_case/add_favorite_use_case.dart';
import 'package:nti_graduation_project/features/favourite/domain/use_case/delete_favorite_use_case.dart';
import 'package:nti_graduation_project/features/favourite/domain/use_case/get_favorite_use_case.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view_model/favorite_states.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(
    this._getFavoriteUseCase,
    this._addFavoriteUseCase,
    this._deleteFavoriteUseCase,
  ) : super(FavoriteIntialState());

  final GetFavoriteUseCase _getFavoriteUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;

  Future<void> getFavorite() async {
    emit(FavoriteLoadingState());
    await _fetchAndEmit();
  }

  Future<void> _fetchAndEmit() async {
    final result = await _getFavoriteUseCase.invoke();
    switch (result) {
      case Success<FavoriteEntity>():
        emit(FavoriteSuccessState(result.data));
      case Error<FavoriteEntity>():
        emit(FavoriteErrorState(result.messageError));
    }
  }

  //////////

  Future<ResultApi<String>> addFavorite(int productId) async {
    final result = await _addFavoriteUseCase.invoke(productId);

    switch (result) {
      case Success<String>():
        await _fetchAndEmit();
      case Error<String>():
        // no list refresh needed on failure
        break;
    }

    return result;
  }

  Future<ResultApi<String>> deleteFavorite(int productId) async {
    final result = await _deleteFavoriteUseCase.invoke(productId);

    switch (result) {
      case Success<String>():
        await _fetchAndEmit();
      case Error<String>():
        break;
    }

    return result;
  }

  bool isFavorite(int productId) {
    final s = state;
    if (s is FavoriteSuccessState) {
      return s.favorites.productList.any((p) => p.id == productId);
    }
    return false;
  }

  Future<ResultApi<String>> toggleFavorite(int productId) async {
    final currentlyFavorite = isFavorite(productId);

    final result = currentlyFavorite
        ? await _deleteFavoriteUseCase.invoke(productId)
        : await _addFavoriteUseCase.invoke(productId);

    switch (result) {
      case Success<String>():
        await _fetchAndEmit();
      case Error<String>():
        break;
    }

    return result;
  }
}