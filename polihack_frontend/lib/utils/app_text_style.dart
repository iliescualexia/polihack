import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle extends TextStyle {
  const AppTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color})
      : super(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decoration: TextDecoration.none,
  );
  factory AppTextStyle.titleStyle(){
    return const AppTextStyle(
      fontSize: 40,
      color: AppColors.paleGrey,
    );
  }
  factory AppTextStyle.lightDefaultStyle(){
    return const AppTextStyle(
      fontSize: 16,
      color: AppColors.paleGrey,
    );
  }
  factory AppTextStyle.darkDefaultStyle(){
    return const AppTextStyle(
      fontSize: 16,
      color: AppColors.darkBlue,
    );
  }
  factory AppTextStyle.focusedDarkStyle(){
    return const AppTextStyle(
      fontSize: 18,
      color: AppColors.darkBlue,
    );
  }
  factory AppTextStyle.focusedLightStyle(){
    return const AppTextStyle(
      fontSize: 18,
      color: AppColors.paleGrey,
    );
  }
  factory AppTextStyle.snackBarStyle(){
    return const AppTextStyle(
      fontSize: 13,
      color: AppColors.darkBlue,
    );
  }
}
