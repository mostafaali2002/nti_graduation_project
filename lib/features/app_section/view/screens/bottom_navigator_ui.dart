import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/account/presentation/view/screens/account_screen.dart';
import 'package:nti_graduation_project/core/constant/app_assets.dart';
import 'package:nti_graduation_project/features/app_section/view_model/app_section_cubit.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:nti_graduation_project/features/home/presentation/view/screens/home_screen.dart';
import 'package:nti_graduation_project/features/app_section/view_model/app_section_states.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_data_source_interface.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_repo_interface.dart';
import '../../../cart/data/repo/cart_data_source_implement.dart';
import '../../../cart/data/repo/cart_repo_implement.dart';
import '../../../cart/domain/use_case/add_cart_use_case.dart';
import '../../../cart/domain/use_case/delete_cart_use_case.dart';
import '../../../cart/domain/use_case/get_cart_use_case.dart';
import '../../../cart/presentation/view/screens/cart_screen.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../widgets/nav_icon.dart';

class BottomNavUI extends StatelessWidget {
  const BottomNavUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppSectionCubit()),
        BlocProvider(create: (context) => createCartCubit()),
      ],
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          final cubit = context.read<AppSectionCubit>();

          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: const [
                HomeScreen(),
                CartScreen(),
                FavouriteScreen(),
                AccountScreen(),
              ],
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

  CartCubit createCartCubit() {
    final CartDataSourceInterface cartDataSource = CartDataSourceImp();
    final CartRepoInterface cartRepo = CartRepoImp(
      cartDataSource: cartDataSource,
    );
    final getCartUseCase = GetCartUseCase(cartRepo: cartRepo);
    final addCartUseCase = AddCartUseCase(cartRepo: cartRepo);
    final deleteCartUseCase = DeleteCartUseCase(cartRepo: cartRepo);

    return CartCubit(
      getCartUseCase: getCartUseCase,
      addCartUseCase: addCartUseCase,
      deleteCartUseCase: deleteCartUseCase,
    );
  }
}