import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import '../../../../../core/common/widgets/item_card.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../app_section/view/widgets/category_cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = AppRoutes.homeRoute;
  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Miscellaneous',
      'Shoes',
      'Furniture',
      'Electronics',
      'ptengan',
      'Mesaq3a',
    ];
    final List<String> clothes = [
      'assets/images/black_t_shirt.png',
      'assets/images/orange_t_shirt.png',
    ];
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCart(title: categories[index]);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 35,
                    mainAxisSpacing: 16.75,
                    childAspectRatio: 0.69,
                  ),
                  itemBuilder: (context, index) {
                    return ItemCard(image: clothes[index % clothes.length]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
