import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:nti_graduation_project/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:nti_graduation_project/features/cart/presentation/view_model/cart_state.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../cart/domain/entities/cart_entity.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String routeName = "ProductDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavourite = false;
  int currentImageIndex = 0;
  bool isAdding = false;

  bool isProductInCart(ProductListEntity product, CartEntity? cart) {
    if (cart == null) return false;
    return cart.productList.any((p) => p.id == product.id);
  }

  @override
  Widget build(BuildContext context) {
    final product =
    ModalRoute.of(context)!.settings.arguments as ProductListEntity;
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 315,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: product.images.length,
                options: CarouselOptions(
                  height: 315,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 300),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentImageIndex = index;
                    });
                  },
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColorStyle.whiteColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColorStyle.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${product.discountPercentage}% OFF",
                                style: AppTextStyle.kTextStyleRegular14
                                    .copyWith(
                                  color: AppColorStyle.lightButtonColor,
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
                                  : const Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Image.network(
                            product.images[itemIndex],
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
                count: product.images.length,
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
                    product.title,
                    style: AppTextStyle.kTextStyleRegular16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "⭐ ${product.rating}",
                  style: AppTextStyle.kTextStyleRegular16,
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Text(
                  "EGP ${(product.price * (1 - product.discountPercentage / 100)).floorToDouble()}",
                  style: AppTextStyle.kTextStyleRegular16,
                ),
                const SizedBox(width: 10),
                Text(
                  "EGP ${product.price.ceilToDouble()}",
                  style: AppTextStyle.kTextStyleDiscount.copyWith(
                    fontSize: AppTextStyle.kTextStyleRegular16.fontSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text("Description", style: AppTextStyle.kTextStyleRegular16),
            const SizedBox(height: 8),
            Text(product.description, style: AppTextStyle.kTextStyleRegular14),
            const SizedBox(height: 24),

            Text("Reviews", style: AppTextStyle.kTextStyleRegular16),
            const SizedBox(height: 8),

            Column(
              children: product.reviews.map((review) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is AddCartSuccess) {
              setState(() {
                isAdding = false;
              });
              context.read<CartCubit>().showSnackBar(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  Navigator.pop(context);
                }
              });
            }
            if (state is DeleteCartSuccess) {
              setState(() {
                isAdding = false;
              });
              context.read<CartCubit>().showSnackBar(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  Navigator.pop(context);
                }
              });
            }
            if (state is AddCartFailure) {
              setState(() {
                isAdding = false;
              });
            }
            if (state is DeleteCartFailure) {
              setState(() {
                isAdding = false;
              });
            }
          },
          builder: (context, state) {
            final isLoading = state is AddCartLoading && isAdding;

            final cart = context.read<CartCubit>().currentCart;
            final isInCart = isProductInCart(product, cart);

            if (isInCart) {
              return CustomButton(
                text: 'Already in cart',
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                borderColor: Colors.grey,
                onPressed: null,
              );
            }

            return CustomButton(
              text: isLoading ? 'Adding...' : 'Add to cart',
              backgroundColor: isLoading
                  ? Colors.grey
                  : AppColorStyle.secondaryButtonColor,
              textColor: isLoading
                  ? Colors.white
                  : AppColorStyle.bottomNavigationBarBackgroundColor,
              borderColor: isLoading
                  ? Colors.grey
                  : AppColorStyle.secondaryButtonColor,
              onPressed: isLoading
                  ? null
                  : () {
                setState(() {
                  isAdding = true;
                });
                context.read<CartCubit>().toggleCart(
                  product.id,
                  productName: product.title,
                );
              },
            );
          },
        ),
      ),
    );
  }
}