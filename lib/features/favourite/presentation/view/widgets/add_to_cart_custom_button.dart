import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';

class AddToCartCustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const AddToCartCustomButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 40),
        backgroundColor: isLoading ? Colors.grey : AppColorStyle.primaryButtonColor,
        elevation: 0,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Text(
        "Add to cart",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}