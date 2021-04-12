import 'package:flutter/material.dart';
import 'package:sport_infrastructure/utils/utils.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;
  final Widget suffixIcon;

  const DefaultTextField(
      {@required this.controller, this.hintText, this.suffixIcon});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      border: Border.all(color: AppColors.blue76CCFF.withOpacity(0.39)),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        style: AppTypography.font16SF.copyWith(
          color: AppColors.black212643,
          height: 1,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIconConstraints: suffixIcon == null
              ? null
              : BoxConstraints.expand(
            width: 40.w,
            height: 40.h,
          ),
          hoverColor: AppColors.blue76CCFF.withOpacity(0.39),
          hintStyle: AppTypography.font16SF.copyWith(
            color: AppColors.grey808088,
            height: 1,
          ),
          suffixIcon: suffixIcon,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    ),
  );
}