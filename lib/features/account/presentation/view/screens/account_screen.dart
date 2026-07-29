import 'package:flutter/material.dart';

import '../../../../../core/routes/app_routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  static const routeName = AppRoutes.accountRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Account Screen")));
  }
}
