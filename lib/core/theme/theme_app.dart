import 'package:flutter/material.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';

abstract class ThemeApp {
  static ThemeData get lightTheme => ThemeData(
    textTheme: lightTextTheme,
    scaffoldBackgroundColor: AppColorStyle.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorStyle.scaffoldBackgroundColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorStyle.bottomNavigationBarBackgroundColor,
      selectedItemColor: AppColorStyle.lightButtonColor,
      unselectedItemColor: AppColorStyle.unselectedBottomNavigationBarColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColorStyle.unselectedBottomNavigationBarColor,
    ),
    fontFamily: 'Inter',
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorStyle.snackBarBackgroundColor,
      contentTextStyle: AppTextStyle.kTextStyleRegular16.copyWith(
        color: AppColorStyle.whiteColor,
      ),
    ),
    dividerColor: AppColorStyle.greyColor,
    splashColor: AppColorStyle.scaffoldBackgroundColor,
    useMaterial3: true,
  );

  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: AppTextStyle.kTextStyleMedium48,
    headlineLarge: AppTextStyle.kTextStyleSemiBold24,
    headlineMedium: AppTextStyle.kTextStyleBold22,
    headlineSmall: AppTextStyle.kTextStyleSemiBold22,
    titleLarge: AppTextStyle.kTextStyleSemiBold18,
    titleMedium: AppTextStyle.kTextStyleMedium18,
    titleSmall: AppTextStyle.kTextStyleRegular18,
    bodyLarge: AppTextStyle.kTextStyleSemiBold16,
    bodyMedium: AppTextStyle.kTextStyleRegular16,
    bodySmall: AppTextStyle.kTextStyleRegular14,
    labelLarge: AppTextStyle.kTextStyleSemiBold14,
    labelMedium: AppTextStyle.kTextStyleMedium14,
    labelSmall: AppTextStyle.kTextStyleRegular12,
  );
}
