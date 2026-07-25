import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/di/service_locator.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'features/app_section/view/screens/bottom_navigator-ui.dart';
import 'package:nti_graduation_project/features/hello/peresentation/hello_screen.dart';
import 'package:nti_graduation_project/features/onboarding/presntaion/onbording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  configureDependencies();
  runApp(const ShoppingApp());
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
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: initialRoute,
      routes: {
        AppRoutes.helloRoute:(context)=>const BottomNavUI(),
        AppRoutes.onBoarding: (context) => const OnbordingScreen(),
        AppRoutes.helloRoute: (context) => const HelloScreen(),
      },
    );
  }
}
