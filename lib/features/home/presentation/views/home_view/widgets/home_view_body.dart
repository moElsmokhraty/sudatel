import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_tab.dart';
import 'announcements_tab.dart';
import '../../../../../../core/styles/app_assets.dart';
import '../../../../../../core/helpers/spacing_helper.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.controller});

  final PageController controller;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(top: 0.08.sh),
      child: Column(
        children: [
          Image.asset(
            AppAssets.sudatelLogo,
            width: 200.w,
            height: 50.h,
          ),
          const VerticalSpace(24),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: 24.w,
                left: 24.w,
                top: 24.h,
                bottom: 90.h,
              ),
              decoration: BoxDecoration(
                color: Color(0XFFF8F8F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: PageView(
                controller: widget.controller,
                physics: const BouncingScrollPhysics(),
                children: const [HomeTab(), AnnouncementsTab()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
