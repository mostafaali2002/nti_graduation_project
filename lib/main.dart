import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'package:nti_graduation_project/features/hello/peresentation/hello_screen.dart';

import 'features/app_section/view/screens/bottom_navigator-ui.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute:  AppRoutes.helloRoute,
      routes: {
        AppRoutes.helloRoute:(context)=>const HelloScreen(),
      },
     
    );
  }
}
