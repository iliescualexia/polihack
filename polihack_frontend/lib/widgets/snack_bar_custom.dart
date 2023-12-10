import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

class SnackBarCustom extends SnackBar {
  final String? text;
  SnackBarCustom({required this.text})
      : super(
    content: Text(
      text!,
      style: AppTextStyle.snackBarStyle(),
    ),
    action: SnackBarAction(
      textColor: AppColors.darkBlue,
      label: 'Close',
      onPressed: () {},
    ),
    backgroundColor: AppColors.paleGrey.withOpacity(0.7),
  );
}
