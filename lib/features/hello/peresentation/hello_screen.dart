import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/constant/app_assets.dart';
import 'package:nti_graduation_project/core/routes/app_routes.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});
  static const String routeName = AppRoutes.helloRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70),
            Image.asset(AppAssets.helloImagePng),
            SizedBox(height: 24),
            Text("Hello!", style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 130),

            CustomButton(
              text: "signUp",
              onPressed: () {},
              backgroundColor: AppColorStyle.lightButtonColor,
              textColor: AppColorStyle.whiteColor,
              borderColor: Colors.transparent,
            ),
            CustomButton(
              text: "Login ",
              onPressed: () {},
              backgroundColor: AppColorStyle.whiteColor,
              textColor: AppColorStyle.lightButtonColor,
              borderColor: AppColorStyle.lightButtonColor,
            ),
          ],
        ),
      ),
    );
  }
}
