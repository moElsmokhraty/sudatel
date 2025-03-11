import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sudatel/core/routing/navigation_extension.dart';
import '../../../cubits/home_cubit/home_cubit.dart';
import '../../../../../../core/widgets/spinkit.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/helpers/spacing_helper.dart';
import '../../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../../core/widgets/buttons/gradient_button.dart';

class OutOfBoundariesDialog extends StatefulWidget {
  const OutOfBoundariesDialog({super.key});

  @override
  State<OutOfBoundariesDialog> createState() => _OutOfBoundariesDialogState();
}

class _OutOfBoundariesDialogState extends State<OutOfBoundariesDialog> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _justificationController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _justificationController = TextEditingController();
  }

  @override
  void dispose() {
    _justificationController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
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
                'Out of Boundaries!',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpace(12),
              Text(
                'Add justification for your current location.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF747474),
                ),
              ),
              const VerticalSpace(16),
              TextFormField(
                maxLines: 3,
                controller: _justificationController,
                decoration: InputDecoration(
                  hintText: 'Write your justification here....',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0XFFAAA9A9),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0XFFAAA9A9),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.darkRed,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.darkRed,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Justification is required';
                  }
                  return null;
                },
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
                buildWhen: (previous, current) =>
                    current is CheckInUserSuccess ||
                    current is CheckInUserError ||
                    current is CheckInUserLoading,
                listener: (context, state) {
                  if (state is CheckInUserSuccess) {
                    context.pop();
                  } else if (state is CheckInUserError) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is! CheckInUserLoading) {
                    return GradientButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<HomeCubit>().checkInUser();
                        }
                      },
                      text: 'Confirm Check In',
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
      ),
    );
  }
}
