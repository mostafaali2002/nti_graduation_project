import 'package:flutter/cupertino.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';

class CategoryCart extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const CategoryCart({super.key, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(),
        ),
        child: Center(
          child: Text(title, style: AppTextStyle.kTextStyleRegular14),
        ),
      ),
    );
  }
}
