import 'package:flutter/material.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import '../../../../../core/constant/app_assets.dart';

class CartItem extends StatelessWidget {
  final ProductListEntity product;
  final int quantity;
  final VoidCallback? onRemove;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  const CartItem({
    super.key,
    required this.product,
    this.quantity = 1,
    this.onRemove,
    this.onIncrease,
    this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: product.thumbnail.isNotEmpty
                ? Image.network(
              product.thumbnail,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppAssets.onboardingTwoImagePng,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              },
            )
                : Image.asset(
              AppAssets.onboardingTwoImagePng,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.close, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EGP ${(product.price.ceilToDouble())-((product.discountPercentage /
                            100)*
                            product.price)
                            .ceilToDouble()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: onDecrease,
                            icon: const Icon(Icons.remove_circle_outline),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: onIncrease,
                            icon: const Icon(Icons.add_circle_outline),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}