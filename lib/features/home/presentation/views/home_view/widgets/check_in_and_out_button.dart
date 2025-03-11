import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../../../core/service/location_service.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../../core/widgets/spinkit.dart';
import '../../../cubits/home_cubit/home_cubit.dart';
import 'early_check_out_dialog.dart';
import 'late_check_in_dialog.dart';
import 'out_of_boundaries_dialog.dart';

class CheckInAndOutButton extends StatefulWidget {
  const CheckInAndOutButton({super.key});

  @override
  State<CheckInAndOutButton> createState() => _CheckInAndOutButtonState();
}

class _CheckInAndOutButtonState extends State<CheckInAndOutButton> {
  late Position _currentPosition;
  late bool isWithinBoundaries;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  Future<void> getCurrentPosition() async {
    _currentPosition = await getIt.get<LocationService>().getCurrentLocation();
    isWithinBoundaries = getIt.get<LocationService>().isWithinAllowedDistance(
          _currentPosition.latitude,
          _currentPosition.longitude,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is CheckInUserSuccess || state is CheckOutUserSuccess) {
          context.read<HomeCubit>().getCheckInAndOutTimes();
        } else if (state is GetCheckInAndOutTimesSuccess) {
          context.read<HomeCubit>().didUserCheckInToday();
        }
      },
      buildWhen: (previous, current) {
        return previous is DidCheckInLoading ||
            current is DidCheckInSuccess ||
            current is DidCheckInError ||
            current is CheckInUserLoading ||
            current is CheckOutUserLoading ||
            current is CheckInUserSuccess ||
            current is CheckOutUserSuccess ||
            current is CheckInUserError ||
            current is CheckOutUserError;
      },
      builder: (context, state) {
        if (state is DidCheckInLoading ||
            state is CheckInUserLoading ||
            state is CheckOutUserLoading) {
          return Center(
            child: SpinKitCircle(
              color: AppColors.darkRed,
              size: 48.r,
            ),
          );
        } else if (state is DidCheckInSuccess) {
          return CustomButton(
            text: state.isCheckIn ? 'Check Out' : 'Check In',
            onPressed: () async {
              await checkInOrOut(isWithinBoundaries, state.isCheckIn);
            },
            color: Colors.white,
            borderSide: BorderSide(
              color: AppColors.darkRed,
              width: 1.8,
            ),
          );
        } else if (state is CheckOutUserError &&
            state.errorMessage == 'You already checked out today') {
          return CustomButton(
            text: 'You already checked out today',
            onPressed: () async {},
            color: Colors.white,
            borderSide: BorderSide(
              color: AppColors.darkRed,
              width: 1.8,
            ),
          );
        } else {
          return CustomButton(
            text: 'Check In',
            onPressed: () async {
              await checkInOrOut(isWithinBoundaries, true);
            },
            color: Colors.white,
            borderSide: BorderSide(
              color: AppColors.darkRed,
              width: 1.8,
            ),
          );
        }
      },
    );
  }

  Future<void> checkInOrOut(
    bool isWithinBoundaries,
    bool isCheckIn,
  ) async {
    if (!isCheckIn) {
      if (DateTime.now().toLocal().isBefore(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              9,
              0,
            ).toLocal(),
          )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You can only check in after 9:00 AM')),
        );
      } else {
        if (!isWithinBoundaries) {
          showDialog(
            context: context,
            builder: (context) => OutOfBoundariesDialog(),
          );
        } else {
          if (DateTime.now().toLocal().isAfter(
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  9,
                  30,
                ).toLocal(),
              )) {
            await showDialog(
              context: context,
              builder: (context) => LateCheckInDialog(),
            );
          } else {
            await context.read<HomeCubit>().checkInUser();
          }
        }
      }
    } else {
      if (DateTime.now().toLocal().isBefore(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              16,
              30,
            ).toLocal(),
          )) {
        await showDialog(
          context: context,
          builder: (context) => EarlyCheckOutDialog(),
        );
      } else {
        await context.read<HomeCubit>().checkOutUser();
      }
    }
  }
}
