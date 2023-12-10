import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../utils/custom_sizes.dart';

class DescriptionTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  const DescriptionTextFieldWidget(
      {super.key,
        required this.controller,
        required this.obscureText,
        required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.lightDefaultStyle(),
      maxLines: 5,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.lightDefaultStyle(),
          errorStyle: TextStyle(color: Colors.red),
          contentPadding: EdgeInsets.all(CustomSizes.defaultOffset() * 2),
          filled: true,
          fillColor: AppColors.deepBlue.withOpacity(0.5),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.purple)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.pastelPurple)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.pastelPurple)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.purple))
      ),
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
    );
  }
}
