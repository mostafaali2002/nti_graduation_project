import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import '../../utils/helper/app_color_style.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.image,
    required this.productName,
    required this.rate,
    required this.productAfterOffer,
    required this.productBeforOffer,
  });
  final String image;
  final String productName;
  final double rate;
  final double productAfterOffer;
  final double productBeforOffer;
  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: .start,
        spacing: 5,
        children: [
          Expanded(
            child: Container(
              color: AppColorStyle.whiteColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavourite = !isFavourite;
                          });
                        },
                        icon: isFavourite
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  Image.network(
                    widget.image,
                    fit: .cover,
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
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(widget.productName, style: AppTextStyle.kTextStyleRegular14),
              Text("⭐${widget.rate}", style: AppTextStyle.kTextStyleRegular14),
            ],
          ),

          Row(
            children: [
              Text(
                "EG ${widget.productAfterOffer}",
                style: AppTextStyle.kTextStyleRegular14,
              ),
              SizedBox(width: 5),
              Text(
                "EG ${widget.productBeforOffer}",
                style: AppTextStyle.kTextStyleDiscount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
