import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../styles/app_colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.height,
    this.width,
    this.colors,
    this.stops,
    required this.onPressed,
    required this.text,
    this.textStyle,
  });

  final double? height;
  final double? width;
  final List<Color>? colors;
  final List<double>? stops;
  final Function() onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 52.h,
        width: width ?? 345.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: colors ??
                [
                  AppColors.darkestRed,
                  AppColors.red,
                  AppColors.darkRed,
                ],
            stops: stops ?? [0.0, 0.38, 1.0],
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
