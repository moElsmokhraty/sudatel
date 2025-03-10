import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'early_check_out_dialog.dart';
import 'home_map.dart';
import 'out_of_boundaries_dialog.dart';
import 'user_info.dart';
import 'balance_container.dart';
import 'check_in_and_out_container.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/helpers/spacing_helper.dart';
import '../../../../../../core/widgets/buttons/custom_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserInfo(),
          const VerticalSpace(24),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckInAndOutContainer(
                      title: 'Check In',
                      time: '08:00 AM',
                      containerColor: AppColors.green.withOpacity(0.1),
                      statusColor: AppColors.green,
                      status: 'On-time',
                    ),
                    CheckInAndOutContainer(
                      title: 'Check Out',
                      time: '05:00 PM',
                      containerColor: AppColors.yellow.withOpacity(0.1),
                      statusColor: AppColors.yellow,
                      status: 'Pending',
                    ),
                  ],
                ),
                const VerticalSpace(16),
                const HomeMap(),
                const VerticalSpace(16),
                CustomButton(
                  text: 'Check Out',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => OutOfBoundariesDialog(),
                    );
                  },
                  color: Colors.white,
                  borderSide: BorderSide(
                    color: AppColors.darkRed,
                    width: 1.8,
                  ),
                ),
              ],
            ),
          ),
          const VerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BalanceContainer(
                title: 'Regular',
                balance: 11,
              ),
              BalanceContainer(
                title: 'Emergency',
                balance: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
