import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';
import '../../utils/helper/app_color_style.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.image});
  final String image;

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
                  Image.asset(widget.image),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("T-shirt oversize",style: AppTextStyle.kTextStyleRegular14),
              Text("⭐4.5",style: AppTextStyle.kTextStyleRegular14,),
            ],
          ),

          Row(
            children: [
              Text("EGP 199",style: AppTextStyle.kTextStyleRegular14,),
              SizedBox(width: 5,),
              Text("EGP 255",style: AppTextStyle.kTextStyleDiscount,)
            ],
          ),
        ],
      ),
    );
  }
}
