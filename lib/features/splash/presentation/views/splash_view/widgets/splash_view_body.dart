import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/spinkit.dart';
import '../../../../../../core/styles/app_assets.dart';
import '../../../../../../core/styles/app_colors.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 1.sh,
          width: 1.sw,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.darkestRed,
                AppColors.red,
                AppColors.darkRed,
              ],
              stops: [0.0, 0.38, 1.0],
            ),
          ),
          child: Image.asset(
            AppAssets.sudatelLogo,
            width: 307.w,
            height: 77.h,
          ),
        ),
        Positioned(
          bottom: 35.h,
          child: SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ],
    );
  }
}
