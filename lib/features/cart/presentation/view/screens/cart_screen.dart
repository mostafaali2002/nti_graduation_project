import 'package:flutter/material.dart';

import '../../../../../core/routes/app_routes.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});
  static const routeName = AppRoutes.cartRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(child: Text("Cart Screen"),),
    );
  }
}