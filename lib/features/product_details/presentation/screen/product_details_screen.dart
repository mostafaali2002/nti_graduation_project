import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String routeName = "ProductDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavourite = false;
  PageController controller = PageController();
  int currentIndex = 0;

  final List<String> images = [
    "assets/images/orange_t_shirt.png",
    "assets/images/black_t_shirt.png",
    "assets/images/orange_t_shirt.png",
  ];
  final List<String> productName = [
    "Nike T-Shirt",
    "poma T-Shirt",
    "adidaas T-Shirt",
  ];
  final List<double> productAfterOffer = [10, 20, 30];
  final List<double> productBeforOffer = [20, 30, 40];

  final List<double> rate = [3.2, 4.5, 4.5];
  final List<String> description = [
    "Elevate your casual wardrobe with our Classic Red Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red hoodie features a kangaroo pocket, adjustable drawstring hood, and ribbed cuffs for a snug fit. The timeless design ensures easy pairing with jeans or joggers for a relaxed yet stylish look, making it a versatile addition to your everyday attire",
    "  casual wardrobe with our Classic Red Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red ",
    "Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red hoodie features a kangaroo pocket, adjustable drawstring hood, and ribbed cuffs for a snug fit. The timeless design ensures easy pairing with jeans or joggers for a relaxed yet stylish look, making it a versatile addition to your everyday attire",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .center,
          spacing: 5,
          children: [
            SizedBox(
              height: 315,
              width: .infinity,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColorStyle.whiteColor,
                    ),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isFavourite = !isFavourite;
                                });
                              },
                              icon: isFavourite
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                        Image.asset(
                          images[index],
                          fit: .cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                itemCount: images.length,
              ),
            ),

            SmoothPageIndicator(
              controller: controller,
              count: images.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 4,
                dotColor: AppColorStyle.lightButtonColor,
                activeDotColor: AppColorStyle.secondaryButtonColor,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                Text(
                  productName[currentIndex],
                  style: AppTextStyle.kTextStyleRegular16,
                ),
                Text(
                  "⭐${rate[currentIndex]}",
                  style: AppTextStyle.kTextStyleRegular16,
                ),
                SizedBox(width: 90),
                Text(
                  "EG ${productAfterOffer[currentIndex]}",
                  style: AppTextStyle.kTextStyleRegular16,
                ),

                Text(
                  "EG ${productBeforOffer[currentIndex]}",
                  style: AppTextStyle.kTextStyleDiscount.copyWith(
                    fontSize: AppTextStyle.kTextStyleRegular16.fontSize,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Text(
              description[currentIndex],
              style: AppTextStyle.kTextStyleRegular16,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        text: 'Add to cart',
        backgroundColor: AppColorStyle.secondaryButtonColor,
        textColor: AppColorStyle.bottomNavigationBarBackgroundColor,
        borderColor: AppColorStyle.secondaryButtonColor,
      ),
    );
  }
}
