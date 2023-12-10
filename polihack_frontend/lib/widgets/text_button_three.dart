import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../utils/custom_sizes.dart';

class TextButtonThree extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  const TextButtonThree({super.key, required this.text, required this.onPressed, required this.icon});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: AppColors.darkBlue
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CustomSizes.defaultHorizontalOffset()*4 ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.paleGrey,),
              Text(
                text,
                style: const AppTextStyle(
                  fontSize: 15,
                  color: AppColors.paleGrey,
                ),
              ),
            ],
          )
      ),
    );
  }
}
