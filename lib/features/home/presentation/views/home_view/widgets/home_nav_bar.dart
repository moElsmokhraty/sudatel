import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/app_assets.dart';
import 'nav_bar_item.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key, required this.controller});

  final PageController controller;

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {
      setState(() {});
    });
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 70.h,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              widget.controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: NavBarItem(
              isSelected: widget.controller.page == 0,
              title: 'Home',
              icon: AppAssets.homeIcon,
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: NavBarItem(
              isSelected: widget.controller.page == 1,
              title: 'Announcements',
              icon: AppAssets.announcementsIcon,
            ),
          )
        ],
      ),
    );
  }
}
