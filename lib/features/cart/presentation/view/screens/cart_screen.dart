import 'package:flutter/material.dart';

import '../../../../../core/routes/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = AppRoutes.cartRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Cart Screen")));
  }
}
