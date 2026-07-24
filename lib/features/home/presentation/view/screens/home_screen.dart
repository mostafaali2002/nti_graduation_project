import 'package:flutter/material.dart';

import '../../../../../core/routes/app_routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const routeName = AppRoutes.homeRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Home Screen")));
  }
}
