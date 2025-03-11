import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sudatel/core/routing/navigation_extension.dart';
import 'package:sudatel/core/widgets/spinkit.dart';
import '../../../../../../core/helpers/spacing_helper.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../../core/widgets/buttons/gradient_button.dart';
import '../../../cubits/home_cubit/home_cubit.dart';

class EarlyCheckOutDialog extends StatelessWidget {
  const EarlyCheckOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0XFFF8F8F8),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Early Checkout!',
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.darkGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VerticalSpace(16),
            Row(
              children: [
                Icon(
                  CupertinoIcons.info,
                  color: AppColors.darkRed,
                  size: 16.r,
                ),
                HorizontalSpace(4),
                Expanded(
                  child: Text(
                    'Incomplete working hours!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpace(16),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is CheckOutUserSuccess) {
                  context.pop();
                } else if (state is CheckOutUserError) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                if (state is! CheckOutUserLoading) {
                  return GradientButton(
                    onPressed: () async {
                      await context.read<HomeCubit>().checkOutUser();
                    },
                    text: 'Confirm Checkout',
                  );
                } else {
                  return SpinKitCircle(
                    color: AppColors.darkRed,
                    size: 48.r,
                  );
                }
              },
            ),
            const VerticalSpace(4),
            CustomButton(
              onPressed: () {
                context.pop();
              },
              text: 'Cancel',
              color: Colors.white,
              textStyle: TextStyle(
                color: Color(0XFF942334),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              borderSide: BorderSide(
                color: AppColors.darkRed,
                width: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
