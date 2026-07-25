import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import '../../../../../core/common/widgets/item_card.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../app_section/view/widgets/category_cart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SafeArea(child: SizedBox()),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Hi!",
                style: AppTextStyle.kTextStyleSemiBold16,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
              child: Text(
                "Let's start your day",
                style: AppTextStyle.kTextStyleSemiBold16,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCart(
                    title: categories[index],
                  );
                },
              ),
            ),
          ),

           SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return ItemCard(
                    image: clothes[index % clothes.length],
                  );
                },
                childCount: 10,
              ),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 35,
                mainAxisSpacing: 16.75,
                childAspectRatio: 0.69,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
