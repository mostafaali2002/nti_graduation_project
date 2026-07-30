import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/account/presentation/view/screens/account_screen.dart';
import 'package:nti_graduation_project/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:nti_graduation_project/core/constant/app_assets.dart';
import 'package:nti_graduation_project/features/app_section/view_model/app_section_cubit.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:nti_graduation_project/features/home/presentation/view/screens/home_screen.dart';
import 'package:nti_graduation_project/features/app_section/view_model/app_section_states.dart';
import '../widgets/nav_icon.dart';

class BottomNavUI extends StatelessWidget {
  const BottomNavUI({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSectionCubit(),
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          final cubit = context.read<AppSectionCubit>();
          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: [
                HomeScreen(),
                CartScreen(),
                FavouriteScreen(),
                AccountScreen(),
              ],
              children: [HomeScreen(), Cart(), Favourite(), Account()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: .fixed,
              currentIndex: cubit.currentIndex,
              onTap: (value) => cubit.changeTab(value),
              items: [
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.homeIconSvg,
                    index: 0,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.cartIconSvg,
                    index: 1,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Cart",
                ),

                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.favIconSvg,
                    index: 2,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Favourite",
                ),

                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.accountIconSvg,
                    index: 3,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Account",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
