import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/features/home/data/repo/home_data_source_imp.dart';
import 'package:nti_graduation_project/features/home/data/repo/home_repo_imp.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_all_product_use_case.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_item_use_case.dart';
import 'package:nti_graduation_project/features/home/presentation/view_model/get_all_product/get_all_product_cubit.dart';
import 'package:nti_graduation_project/features/home/presentation/view_model/get_category_cubit/get_category_cubit.dart';
import 'package:nti_graduation_project/features/products_by_category/presentation/view/screen/products_by_category_screen.dart';
import '../../../../../core/common/widgets/item_card.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../app_section/view/widgets/category_cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = AppRoutes.homeRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text("Hi!", style: AppTextStyle.kTextStyleSemiBold16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Let's start your day",
                    style: AppTextStyle.kTextStyleSemiBold16,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: BlocProvider(
                      create: (context) => GetCategoryCubit(
                        GetCategoriesUseCase(HomeRepoImp(HomeDataSourceImp())),
                      )..getcatgories(),
                      child: BlocBuilder<GetCategoryCubit, GetCategoryState>(
                        builder: (context, state) {
                          if (state is GetCategoryLoading ||
                              state is GetCategoryInitial) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is GetCategoryFailure) {
                            return Center(child: Text(state.errorMessage));
                          } else if (state is GetCategorySuccess) {
                            final categories = state.categories;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return CategoryCart(
                                  title: category.name,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductsByCategoryScreen(
                                              slug: category.slug,
                                              categoryName: category.name,
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                BlocProvider(
                  create: (context) => GetAllProductCubit(
                    getAllProductUseCase: GetAllProductUseCase(
                      HomeRepoImp(HomeDataSourceImp()),
                    ),
                  )..getAllProduct(),
                  child: BlocBuilder<GetAllProductCubit, GetAllProductState>(
                    builder: (context, state) {
                      if (state is GetAllProductLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GetAllProductFailure) {
                        return Center(child: Text(state.errorMessage));
                      } else if (state is GetAllProductSuccess) {
                        final product = state.list;

                        return GridView.builder(
                          itemCount: product.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 35,
                                mainAxisSpacing: 16.75,
                                childAspectRatio: 0.69,
                              ),
                          itemBuilder: (context, index) {
                            return ItemCard(
                              image: product[index].thumbnail,
                              productName: product[index].title,
                              rate: product[index].rating,
                              productAfterOffer: product[index].price,
                              productBeforeOffer:
                                  product[index].discountPercentage,
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text("Something Wrong out of data"),
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
