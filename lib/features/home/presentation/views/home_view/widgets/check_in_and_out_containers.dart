import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
                status: checkCheckInStatus(
                  state.checkInAndOutTimes.checkInTime,
                ),
              ),
              CheckInAndOutContainer(
                title: 'Check Out',
                time: state.checkInAndOutTimes.checkOutTime ?? '05:00 PM',
                containerColor: AppColors.yellow.withOpacity(0.1),
                statusColor: AppColors.yellow,
                status: checkCheckOutStatus(
                  state.checkInAndOutTimes.checkOutTime,
                ),
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
            size: 40.r,
          );
        }
      },
    );
  }

  String checkCheckInStatus(String? checkInTime) {
    if (checkInTime == null) return 'Pending';
    final DateFormat format = DateFormat('hh:mm a');
    final DateTime checkIn = format.parse(checkInTime);
    final DateTime lateTime = format.parse('09:30 AM');

    return checkIn.isAfter(lateTime) ? 'Late Check In' : 'On-Time';
  }

  String checkCheckOutStatus(String? checkOutTime) {
    if (checkOutTime == null) return 'Pending';
    final DateFormat format = DateFormat('hh:mm a');
    final DateTime checkOut = format.parse(checkOutTime);
    final DateTime earlyTime = format.parse('04:30 PM');

    return checkOut.isBefore(earlyTime) ? 'Early Check Out' : 'On-Time';
  }
}
