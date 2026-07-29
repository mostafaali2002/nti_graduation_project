import 'package:flutter/material.dart';

import '../../../../../core/routes/app_routes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const routeName = AppRoutes.favRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(child: Text("Favourite Screen"),),
    );
  }
}