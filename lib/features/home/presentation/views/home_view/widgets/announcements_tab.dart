import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'announcement_item.dart';
import '../../../../../../core/styles/app_colors.dart';

class AnnouncementsTab extends StatelessWidget {
  const AnnouncementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Text(
            'Announcements',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
        ),
        SliverFillRemaining(
          child: ListView.separated(
            itemCount: 10,
            padding: EdgeInsets.only(top: 24.h),
            separatorBuilder: (context, index) => Divider(
              color: Color(0XFFAAA9A9).withOpacity(0.16),
            ),
            itemBuilder: (context, index) => AnnouncementItem(
              title: 'Announcement Title',
              subtitle: 'Announcement Subtitle',
              date: '12/12/2021',
            ),
          ),
        ),
      ],
    );
  }
}
