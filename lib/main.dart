import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/theme/theme_app.dart';
import 'package:nti_graduation_project/shopping_home_screen.dart';

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
      home: ShoppingHomeScreen(),
      /*initialRoute: '/',
      routes: {},*/
    );
  }
}
