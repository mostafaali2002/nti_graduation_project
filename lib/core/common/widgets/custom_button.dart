import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });
  final Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
