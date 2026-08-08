import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/constant/app_assets.dart';

import '../../../../../core/routes/app_routes.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});
  static const routeName = AppRoutes.cartRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 12,
          children: [
            Image.asset(AppAssets.cartImagePng),
            Text("your cart is empty")
          ],
        ),
      )
    );
  }
}