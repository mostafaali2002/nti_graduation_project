import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';

class AddToCartCustomButton extends StatelessWidget {
  AddToCartCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 40),
          backgroundColor: AppColorStyle.primaryButtonColor,
          elevation: 0,
          padding: EdgeInsets.zero,

          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "Add to cart",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      
    );
  }
}
