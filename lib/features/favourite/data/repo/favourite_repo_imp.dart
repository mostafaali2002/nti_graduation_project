import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart';
import '../../../../core/network/result_api.dart';
@Injectable(as:FavoriteRepoInterface)
class FavoriteRepoImp implements FavoriteRepoInterface {
  final FavoriteDataSourceInterface favoriteDataSource;

  FavoriteRepoImp({required this.favoriteDataSource});

  @override
 
Future<ResultApi<FavoriteEntity>> getFavorite() async {
  try {
    final result = await favoriteDataSource.getFavorite();

    switch (result) {
      case Success<FavoriteEntity>(data: final data):
        return Success(data);

      case Error<FavoriteEntity>(messageError: final message):
        return Error(message);
    }
  } catch (e) {
    return Error(e.toString());
  }
}


  

  @override
Future<ResultApi<String>> addFavorite({
  required String productId,
}) async {
  try {
    final result = await favoriteDataSource.addFavorite(
      productId: productId,
    );

    switch (result) {
      case Success<String>(data: final data):
        return Success(data);

      case Error<String>(messageError: final message):
        return Error(message);
    }
  } catch (e) {
    return Error(e.toString());
  }
}

@override
Future<ResultApi<String>> deleteFavorite({
  required String productId,
}) async {
  try {
    final result = await favoriteDataSource.deleteFavorite(
      productId: productId,
    );

    switch (result) {
      case Success<String>(data: final data):
        return Success(data);

      case Error<String>(messageError: final message):
        return Error(message);
    }
  } catch (e) {
    return Error(e.toString());
  }
}}