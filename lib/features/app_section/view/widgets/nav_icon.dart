import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class NavIcon extends StatelessWidget {
  const NavIcon({super.key, required this.path,required this.index,required this.currentIndex});
  final String path;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        currentIndex == index
            ? Colors.orange
            : Colors.grey,
        BlendMode.srcIn,
      ),
    );
  }
}



