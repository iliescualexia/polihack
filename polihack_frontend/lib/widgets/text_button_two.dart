import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../utils/custom_sizes.dart';

class TextButtonTwo extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TextButtonTwo({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CustomSizes.defaultHorizontalOffset()*4 ),
          child: Text(
            text,
            style: const AppTextStyle(
                fontSize: 15,
                color: AppColors.paleGrey,
                fontWeight: FontWeight.bold
            ),
          )
      ),
    );
  }
}
