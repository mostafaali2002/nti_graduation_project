import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/features/home/data/repo/home_data_source_imp.dart';
import 'package:nti_graduation_project/features/home/data/repo/home_repo_imp.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_all_product_use_case.dart';
import 'package:nti_graduation_project/features/home/presentation/view_model/get_all_product/get_all_product_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String routeName = "ProductDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavourite = false;

  int currentIndex = 0;
  int currentImageIndex = 0;
  final List<String> images = ['assets/images/orange_t_shirt.png'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetAllProductCubit>(
      create: (context) => GetAllProductCubit(
        getAllProductUseCase: GetAllProductUseCase(
          HomeRepoImp(HomeDataSourceImp()),
        ),
      )..getAllProduct(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<GetAllProductCubit, GetAllProductState>(
            builder: (context, state) {
              if (state is GetAllProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetAllProductFailure) {
                return Center(child: Text(state.errorMessage));
              } else if (state is GetAllProductSuccess) {
                final product = state.list;
                final currentImage = product[currentIndex].images;
                if (currentImage.isEmpty) {
                  return const Center(child: Text("No Images Available"));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 315,
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: currentImage.length,
                        options: CarouselOptions(
                          height: 315,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: const Duration(
                            milliseconds: 300,
                          ),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentImageIndex = index;
                            });
                          },
                        ),
                        itemBuilder:
                            (
                              BuildContext context,
                              int itemIndex,
                              int pageViewIndex,
                            ) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColorStyle.whiteColor,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColorStyle.whiteColor,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            "${product[currentIndex].discountPercentage}% OFF",
                                            style: AppTextStyle
                                                .kTextStyleRegular14
                                                .copyWith(
                                                  color: AppColorStyle
                                                      .lightButtonColor,
                                                ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isFavourite = !isFavourite;
                                            });
                                          },
                                          icon: isFavourite
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite_border,
                                                ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Image.network(
                                        currentImage[itemIndex],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                      ),
                    ),
                    const SizedBox(height: 12),

                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentImageIndex,
                        count: currentImage.length,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 4,
                          dotColor: AppColorStyle.lightButtonColor,
                          activeDotColor: AppColorStyle.secondaryButtonColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product[currentIndex].title,
                            style: AppTextStyle.kTextStyleRegular16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "⭐ ${product[currentIndex].rating}",
                          style: AppTextStyle.kTextStyleRegular16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Text(
                          "EGP ${((product[currentIndex].price) - (product[currentIndex].price * product[currentIndex].discountPercentage / 100)).toStringAsFixed(2)}",
                          style: AppTextStyle.kTextStyleRegular16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "EGP ${product[currentIndex].price}",
                          style: AppTextStyle.kTextStyleDiscount.copyWith(
                            fontSize: AppTextStyle.kTextStyleRegular16.fontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "Description",
                      style: AppTextStyle.kTextStyleRegular16,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product[currentIndex].description,
                      style: AppTextStyle.kTextStyleRegular14,
                    ),
                    const SizedBox(height: 24),

                    Text("Reviews", style: AppTextStyle.kTextStyleRegular16),
                    const SizedBox(height: 8),

                    Column(
                      children: product[currentIndex].reviews.map((review) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColorStyle.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.reviewerName,
                                    style: AppTextStyle.kTextStyleRegular14,
                                  ),
                                  Text(
                                    "⭐ ${review.rating}",
                                    style: AppTextStyle.kTextStyleRegular14,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                review.comment,
                                style: AppTextStyle.kTextStyleRegular14,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              } else {
                return Center(child: Text("Something Wrong out of data"));
              }
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            text: 'Add to cart',
            backgroundColor: AppColorStyle.secondaryButtonColor,
            textColor: AppColorStyle.bottomNavigationBarBackgroundColor,
            borderColor: AppColorStyle.secondaryButtonColor,
          ),
        ),
      ),
    );
  }
}
