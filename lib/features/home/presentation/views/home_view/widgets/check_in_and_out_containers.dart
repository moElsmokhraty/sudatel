import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'check_in_and_out_container.dart';
import '../../../cubits/home_cubit/home_cubit.dart';
import '../../../../../../core/widgets/spinkit.dart';
import '../../../../../../core/styles/app_colors.dart';

class CheckInAndOutContainers extends StatelessWidget {
  const CheckInAndOutContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetCheckInAndOutTimesSuccess ||
          current is GetCheckInAndOutTimesError ||
          current is GetCheckInAndOutTimesLoading,
      builder: (context, state) {
        if (state is GetCheckInAndOutTimesSuccess) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckInAndOutContainer(
                title: 'Check In',
                time: state.checkInAndOutTimes.checkInTime ?? '09:00 AM',
                containerColor: AppColors.green.withOpacity(0.1),
                statusColor: AppColors.green,
                status: state.checkInAndOutTimes.checkInTime == null
                    ? 'Pending'
                    : 'On-time',
              ),
              CheckInAndOutContainer(
                title: 'Check Out',
                time: state.checkInAndOutTimes.checkOutTime ?? '05:00 PM',
                containerColor: AppColors.yellow.withOpacity(0.1),
                statusColor: AppColors.yellow,
                status: state.checkInAndOutTimes.checkOutTime == null
                    ? 'Pending'
                    : 'On-time',
              ),
            ],
          );
        } else if (state is GetCheckInAndOutTimesError) {
          return Text(
            state.errorMessage,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGrey,
            ),
          );
        } else {
          return SpinKitCircle(
            color: AppColors.darkRed,
            size: 24.r,
          );
        }
      },
    );
  }
}
