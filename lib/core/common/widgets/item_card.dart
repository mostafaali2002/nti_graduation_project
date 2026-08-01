import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import '../../utils/helper/app_color_style.dart';
import 'custom_favorite.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.image,
    required this.productName,
    required this.rate,
    required this.productAfterOffer,
    required this.productBeforeOffer,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.productId=0,  final VoidCallback? onFavoriteToggle,
  });

  final String image;
  final String productName;
  final double rate;
  final double productAfterOffer;
  final double productBeforeOffer;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: AppColorStyle.whiteColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FavoriteIconButton(productId: productId,),
                    ],
                  ),
                  Expanded(
                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
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
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  productName,
                  style: AppTextStyle.kTextStyleRegular14,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text("⭐$rate", style: AppTextStyle.kTextStyleRegular14),
            ],
          ),
          Row(
            children: [
              Text(
                "EGP $productAfterOffer",
                style: AppTextStyle.kTextStyleRegular14,
              ),
              const SizedBox(width: 5),
              Text(
                "EGP $productBeforeOffer",
                style: AppTextStyle.kTextStyleDiscount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}