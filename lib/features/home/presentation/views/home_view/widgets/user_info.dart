import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/app_assets.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/helpers/spacing_helper.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(AppAssets.avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        HorizontalSpace(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Muhammad!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Development Team',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 48.w,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child: Image.asset(
            AppAssets.logout,
            width: 24.w,
            height: 24.h,
          ),
        ),
      ],
    );
  }
}
