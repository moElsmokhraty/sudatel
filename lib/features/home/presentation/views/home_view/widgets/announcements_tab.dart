import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'announcement_item.dart';
import 'package:sudatel/core/widgets/spinkit.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../data/models/announcement_model.dart';

class AnnouncementsTab extends StatefulWidget {
  const AnnouncementsTab({super.key});

  @override
  State<AnnouncementsTab> createState() => _AnnouncementsTabState();
}

class _AnnouncementsTabState extends State<AnnouncementsTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<AnnouncementModel>> getAnnouncements() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("announcements").get();
    return snapshot.docs
        .map((doc) =>
            AnnouncementModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          child: FutureBuilder(
            future: getAnnouncements(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitCircle(
                    color: AppColors.darkRed,
                    size: 50.0,
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return RefreshIndicator(
                  color: AppColors.darkRed,
                  onRefresh: () async {
                    await getAnnouncements();
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.only(top: 24.h),
                    separatorBuilder: (context, index) => Divider(
                      color: Color(0XFFAAA9A9).withOpacity(0.16),
                    ),
                    itemBuilder: (context, index) => AnnouncementItem(
                      title: snapshot.data![index].title,
                      subtitle: snapshot.data![index].subtitle,
                      date: snapshot.data![index].date,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error.toString()}'),
                );
              } else {
                return Center(
                  child: Text('No data found'),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
