import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/constant/app_keys.dart';
import 'package:nti_graduation_project/core/di/service_locator.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/storage_helper/secure_storage_helper.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'package:nti_graduation_project/core/utils/bloc/my_bloc_observer.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/core/utils/my_bloc_observer.dart';
import 'package:nti_graduation_project/features/app_section/view/screens/bottom_navigator-ui.dart';
// import 'package:nti_graduation_project/features/app_section/view/screens/bottom_navigator-ui.dart';
import 'package:nti_graduation_project/features/auth/presentation/view/screen/login_screen.dart';
import 'package:nti_graduation_project/features/auth/presentation/view/screen/register_screen.dart';
import 'package:nti_graduation_project/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:nti_graduation_project/features/auth/presentation/view_model/register/register_cubit.dart';
import 'package:nti_graduation_project/features/hello/peresentation/hello_screen.dart';
import 'package:nti_graduation_project/features/home/presentation/view/screens/home_screen.dart';
import 'package:nti_graduation_project/features/onboarding/presntaion/onbording_screen.dart';
import 'package:nti_graduation_project/features/product_details/presentation/screen/product_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  String? token = await serviceLocator<SecureStorageHelper>().getSecure(
    key: AppKeys.token,
  );
  DioHelper.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnBoardingDone = prefs.getBool("onBoardingDone") ?? false;

  String initialRoute = isOnBoardingDone
      ? AppRoutes.helloRoute
      : AppRoutes.onBoarding;

  runApp(ShoppingApp(initialRoute: initialRoute, token: token));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key, required this.initialRoute, this.token});
  final String initialRoute;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? AppRoutes.homeRoute : initialRoute,
      routes: {
        AppRoutes.onBoarding: (_) => const OnbordingScreen(),
        AppRoutes.helloRoute: (_) => const HelloScreen(),
        AppRoutes.homeRoute: (_) => const BottomNavUI(),
        AppRoutes.loginRoute: (_) => BlocProvider(
          create: (context) => serviceLocator<LoginCubit>(),
          child: LoginScreen(),
        ),
        AppRoutes.signupRoute: (_) => BlocProvider(
          create: (_) => serviceLocator<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
        AppRoutes.productdetailsRoute: (_) => const ProductDetailsScreen(),
      },
    );
  }
}
