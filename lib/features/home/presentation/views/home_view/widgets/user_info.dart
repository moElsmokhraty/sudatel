import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sudatel/core/routing/navigation_extension.dart';
import '../../../../../../core/routing/app_routes.dart';
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
            SizedBox(
              width: 230.w,
              child: Text(
                'Hello ${FirebaseAuth.instance.currentUser!.displayName}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
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
        GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut().then((value) async {
              if (context.mounted) {
                await context.pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  predicate: (route) => false,
                );
              }
            });
          },
          child: Container(
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
        ),
      ],
    );
  }
}
