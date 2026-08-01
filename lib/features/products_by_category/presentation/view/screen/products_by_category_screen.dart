import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/features/home/data/repo/home_data_source_imp.dart';
import 'package:nti_graduation_project/features/home/data/repo/home_repo_imp.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_products_by_category_use_case.dart';
import 'package:nti_graduation_project/features/products_by_category/presentation/view_model/productsbycatgory/get_products_by_category_cubit.dart';
import 'package:nti_graduation_project/features/search/presentation/view/search_screen.dart';
import '../../../../../core/common/widgets/item_card.dart';
import '../../../../../core/routes/app_routes.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.categoryName,
  });

  final String slug;
  final String categoryName;
  static const routeName = AppRoutes.productByCatgoryRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryName, style: AppTextStyle.kTextStyleSemiBold22),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                BlocProvider(
                  create: (context) => GetProductsByCategoryCubit(
                    getProductsByCategoryUseCase: GetProductsByCategoryUseCase(
                      HomeRepoImp(HomeDataSourceImp()),
                    ),
                  )..getProductsByCategory(slug: slug),
                  child:
                      BlocBuilder<
                        GetProductsByCategoryCubit,
                        GetProductsByCategoryState
                      >(
                        builder: (context, state) {
                          if (state is GetProductsByCategoryLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetProductsByCategoryFailure) {
                            return Center(child: Text(state.errorMessage));
                          } else if (state is GetProductsByCategorySuccess) {
                            final product = state.list;

                            return GridView.builder(
                              itemCount: product.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 35,
                                    mainAxisSpacing: 16.75,
                                    childAspectRatio: 0.69,
                                  ),
                              itemBuilder: (context, index) {
                                final currentProduct = product[index];

                                return ItemCard(
                                  productId: currentProduct.id,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.productdetailsRoute,
                                      arguments: currentProduct,
                                    );
                                  },
                                  image: currentProduct.thumbnail,
                                  productName: currentProduct.title,
                                  rate: currentProduct.rating,
                                  productAfterOffer:
                                      (currentProduct.price *
                                              (1 -
                                                  (currentProduct
                                                          .discountPercentage /
                                                      100)))
                                          .ceilToDouble(),
                                  productBeforeOffer: currentProduct.price
                                      .ceilToDouble(),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("Something went wrong loading data"),
                            );
                          }
                        },
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
