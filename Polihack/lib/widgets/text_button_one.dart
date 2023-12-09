import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../utils/custom_sizes.dart';

class TextButtonOne extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TextButtonOne({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: AppColors.paleGrey
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CustomSizes.defaultHorizontalOffset()*4 ),
          child: Text(
            text,
            style: const AppTextStyle(
              fontSize: 15,
              color: AppColors.deepBlue,
            ),
          )
      ),
    );
  }
}
