import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing_helper.dart';
import '../../../../../../core/styles/app_colors.dart';

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  final String title;
  final String subtitle;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGrey,
          ),
        ),
        VerticalSpace(8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.darkGrey,
          ),
        ),
        VerticalSpace(8),
        Text(
          date,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Color(0XFF747474),
          ),
        ),
      ],
    );
  }
}
