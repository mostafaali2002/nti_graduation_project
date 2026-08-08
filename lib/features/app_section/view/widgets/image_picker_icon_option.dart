import 'package:flutter/material.dart';

class ImagePickerIconOption extends StatelessWidget {
  const ImagePickerIconOption({
    super.key,
    required this.iconName,
    required this.iconData,
    this.onTap,
  });
  final String iconName;
  final IconData iconData;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(iconData, size: 42),
          SizedBox(height: 12),
          Text(iconName, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
