import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubit.dart';

Widget navIcon({
  required String path,
  required int index,
  required HomeCubit cubit,
}) {
  return SvgPicture.asset(
    path,
    colorFilter: ColorFilter.mode(
      cubit.currentIndex == index
          ? Colors.orange
          : Colors.grey,
      BlendMode.srcIn,
    ),
  );
}