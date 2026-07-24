import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../view_model/app_section_cubit.dart';
class NavIcon extends StatelessWidget {
  const NavIcon({super.key, required this.path,required this.index,required this.homeCubit});
  final String path;
  final int index;
  final AppSectionCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        homeCubit.currentIndex == index
            ? Colors.orange
            : Colors.grey,
        BlendMode.srcIn,
      ),
    );
  }
}



