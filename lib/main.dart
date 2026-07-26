import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'package:nti_graduation_project/features/app_section/view/screens/bottom_navigator-ui.dart';
import 'package:nti_graduation_project/features/auth/presentation/view/screen/register_screen.dart';
import 'package:nti_graduation_project/features/hello/peresentation/hello_screen.dart';
import 'package:nti_graduation_project/features/onboarding/presntaion/onbording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialRoute: AppRoutes.signupRoute,
      routes: {
        AppRoutes.onBoarding: (_) => const OnbordingScreen(),
        AppRoutes.helloRoute: (_) => const HelloScreen(),
        AppRoutes.homeRoute: (_) => const BottomNavUI(),
        AppRoutes.signupRoute: (_) => const RegisterScreen(),
      },
    );
  }
}
