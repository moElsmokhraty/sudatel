import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.width,
    this.height,
    this.color,
    this.borderSide,
    this.borderRadius,
  });

  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final Color? color;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.white,
        fixedSize: Size(width ?? 1.sw, height ?? 51.h),
        side: borderSide,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkRed,
            ),
      ),
    );
  }
}
