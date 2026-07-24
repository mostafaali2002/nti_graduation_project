import 'package:flutter/material.dart';
import '../../utils/helper/app_color_style.dart';

class ItemCard extends StatefulWidget {
  ItemCard({super.key, required this.image});
  String image;

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
                            ? Icon(Icons.favorite, color: Colors.black)
                            : Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  Image.asset(widget.image),
                ],
              ),
            ),
          ),
          Text("T-shirt oversize"),
          Text("EGP 199"),
        ],
      ),
    );
  }
}
