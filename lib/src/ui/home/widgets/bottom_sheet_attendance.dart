import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/services/firebase_firestore/attendance_firestore.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/classes/widgets/user_request_card.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomSheetAttendance extends StatefulWidget {
  final String title;
  final String roadmapContentId;
  const BottomSheetAttendance({required this.title, required this.roadmapContentId});
  @override
  State<StatefulWidget> createState() => _BottomSheetAttendanceState();
}

class _BottomSheetAttendanceState extends State<BottomSheetAttendance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 8.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    AppNavigator.pop();
                  },
                  icon: Icon(
                    PhosphorIcons.x,
                    color: colorPrimary,
                    size: 20.sp,
                  ),
                ),
                Text('${widget.title} đã điểm danh'),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    null,
                    color: colorPrimary,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: AttendanceFirestore().getAttendance(widget.roadmapContentId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 16.sp),
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return UserRequestCard(
                        user: snapshot.data![index],
                        isLast: index == snapshot.data!.length - 1,
                      );
                    },
                  );
                }

                return Center();
              },
            ),
          ),
        ],
      ),
    );
  }
}
