import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/app_assets.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.loginBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset(
        AppAssets.sudatelLogo,
        width: 307.w,
        height: 77.h,
      ),
    );
  }
}
