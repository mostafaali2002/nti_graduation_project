import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/common/widgets/item_card.dart';
import 'package:nti_graduation_project/core/di/service_locator.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view/widgets/add_to_cart_custom_button.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view_model/favorite_cubit.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view_model/favorite_states.dart';

import '../../../../../core/routes/app_routes.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});
  static const routeName = AppRoutes.favRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (_) => serviceLocator<FavoriteCubit>()..getFavorite(),
      child: Scaffold(
        appBar: AppBar(
          
          title: Text("My Favorite",
           style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: true,
        ),
        body: BlocConsumer<FavoriteCubit, FavoriteStates>(
          listener: (context, state) {
            if (state is FavoriteErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is FavoriteLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoriteErrorState) {
              return Center(child: Text(state.error));
            } else if (state is FavoriteSuccessState) {
              final products = state.favorites.productList;

              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 120,
                        color: AppColorStyle.secondaryButtonColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "There are no products in your favourite list ",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: const Color(0xff2F2F2F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 35,
                  mainAxisSpacing: 16.75,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ItemCard(
                          image: product.thumbnail,
                          productName: product.title,
                          rate: product.rating,
                          productAfterOffer: product.price,
                          productBeforOffer: product.discountPercentage,
                          isFavorite: true,
                          onFavoriteTap: () =>
                              _handleToggle(context, product.id),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: AddToCartCustomButton(),
                      ),
                    ],
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<void> _handleToggle(BuildContext context, int productId) async {
    final cubit = context.read<FavoriteCubit>();
    final wasFavorite = cubit.isFavorite(productId);
    final result = await cubit.toggleFavorite(productId);

    if (!context.mounted) return;

    switch (result) {
      case Success<String>():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              wasFavorite ? "Removed from favourites" : "Added to favourites",
            ),
          ),
        );
      case Error<String>(messageError: final message):
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
