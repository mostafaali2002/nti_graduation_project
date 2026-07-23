import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/account.dart';
import 'package:nti_graduation_project/cart.dart';
import 'package:nti_graduation_project/cubit.dart';
import 'package:nti_graduation_project/favourite.dart';
import 'package:nti_graduation_project/home.dart';
import 'package:nti_graduation_project/states.dart';

import 'core/common/widgets/nav_icon.dart';

class ShoppingHomeScreen extends StatelessWidget {
  const ShoppingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, States>(
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: [Home(), Cart(), Favourite(), Account()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: .fixed,
              currentIndex: cubit.currentIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.orange,
              onTap: (value) => cubit.move(value),
              items: [
                BottomNavigationBarItem(
                  icon: navIcon(path: 'assets/icons/home.svg', index: 0, cubit: cubit),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: navIcon(path: 'assets/icons/cart.svg', index: 1, cubit: cubit),
                  label: "Cart",
                ),

                BottomNavigationBarItem(
                  icon: navIcon(path: 'assets/icons/fav.svg', index: 2, cubit: cubit),
                  label: "Favourite",
                ),

                BottomNavigationBarItem(
                  icon: navIcon(path: 'assets/icons/account.svg', index: 3, cubit: cubit),
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
