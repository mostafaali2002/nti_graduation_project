import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import '../../utils/helper/app_color_style.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.image,
    required this.productName,
    required this.rate,
    required this.productAfterOffer,
    required this.productBeforOffer,
     this.isFavorite=false,
     this.onFavoriteTap,
  });

  final String image;
  final String productName;
  final double rate;
  final double productAfterOffer;
  final double productBeforOffer;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Expanded(
            child: Container(
              color: AppColorStyle.whiteColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onFavoriteTap,
                        icon: isFavorite
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(productName, style: AppTextStyle.kTextStyleRegular14),
              Text("⭐$rate", style: AppTextStyle.kTextStyleRegular14),
            ],
          ),
          Row(
            children: [
              Text(
                "EG $productAfterOffer",
                style: AppTextStyle.kTextStyleRegular14,
              ),
              const SizedBox(width: 5),
              Text(
                "EG $productBeforOffer",
                style: AppTextStyle.kTextStyleDiscount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}