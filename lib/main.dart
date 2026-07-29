import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'package:nti_graduation_project/features/hello/peresentation/hello_screen.dart';
import 'package:nti_graduation_project/features/home/presentation/view/screens/home_screen.dart';
import 'package:nti_graduation_project/features/onboarding/presntaion/onbording_screen.dart';
import 'package:nti_graduation_project/features/search/presentation/view/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/helper/dio_helper.dart';
import 'features/app_section/view/screens/bottom_navigator_ui.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();

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
      initialRoute: AppRoutes.bottomNavUI,
      routes: {
        AppRoutes.onBoarding: (_) => const OnbordingScreen(),
        AppRoutes.helloRoute: (_) => const HelloScreen(),
        AppRoutes.homeRoute: (_) => const HomeScreen(),
        AppRoutes.bottomNavUI: (_) => const BottomNavUI(),
        AppRoutes.searchScreen:(_)=>const SearchScreen(),
      },
    );
  }
}
