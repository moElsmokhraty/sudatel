import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing_helper.dart';
import '../../../../../../core/styles/app_colors.dart';

class CheckInAndOutContainer extends StatelessWidget {
  const CheckInAndOutContainer({
    super.key,
    required this.title,
    required this.time,
    required this.containerColor,
    required this.statusColor,
    required this.status,
  });

  final String title;
  final String time;
  final Color containerColor;
  final Color statusColor;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145.w,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGrey,
            ),
          ),
          VerticalSpace(8),
          Text(
            time,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          VerticalSpace(8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.w,
                  height: 6.h,
                  margin: EdgeInsets.only(right: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                  ),
                ),
                SizedBox(
                  width: 75.w,
                  child: Text(
                    status,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: status == 'Early Check Out' ||
                              status == 'Late Check In'
                          ? 10.sp
                          : 12.sp,
                      fontWeight: FontWeight.w400,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
