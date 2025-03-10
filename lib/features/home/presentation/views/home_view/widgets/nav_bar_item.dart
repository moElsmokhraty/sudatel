import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/app_colors.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
  });

  final bool isSelected;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 62.h,
      width: 176.5.w,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.darkRed : Colors.transparent,
        borderRadius: BorderRadius.circular(isSelected ? 24.r : 0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 24.h,
            width: 24.w,
            color: isSelected ? Colors.white : AppColors.darkGrey,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.darkGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
