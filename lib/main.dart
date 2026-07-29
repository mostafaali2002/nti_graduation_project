import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/di/service_locator.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'package:nti_graduation_project/core/utils/helper/dio_helper.dart';
import 'package:nti_graduation_project/core/utils/my_bloc_observer.dart';
import 'package:nti_graduation_project/features/app_section/view/screens/bottom_navigator-ui.dart';
// import 'package:nti_graduation_project/features/app_section/view/screens/bottom_navigator-ui.dart';
import 'package:nti_graduation_project/features/auth/presentation/view/screen/login_screen.dart';
import 'package:nti_graduation_project/features/auth/presentation/view/screen/register_screen.dart';
import 'package:nti_graduation_project/features/auth/presentation/view_model/register/register_cubit.dart';
import 'package:nti_graduation_project/features/hello/peresentation/hello_screen.dart';
import 'package:nti_graduation_project/features/onboarding/presntaion/onbording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  configureDependencies();
  bool isOnBoardingDone = prefs.getBool("onBoardingDone") ?? false;

  String initialRoute = isOnBoardingDone
      ? AppRoutes.helloRoute
      : AppRoutes.onBoarding;

  runApp(ShoppingApp(initialRoute: initialRoute));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRoute,
      routes: {
        AppRoutes.onBoarding: (_) => const OnbordingScreen(),
        AppRoutes.helloRoute: (_) => const HelloScreen(),
        AppRoutes.homeRoute: (_) => const BottomNavUI(),
        AppRoutes.loginRoute: (_) => const LoginScreen(),

        AppRoutes.signupRoute: (_) => BlocProvider(
          create: (_) => serviceLocator<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      },
    );
  }
}
