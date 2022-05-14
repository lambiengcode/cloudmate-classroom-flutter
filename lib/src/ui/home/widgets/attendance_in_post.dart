import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/services/firebase_firestore/attendance_firestore.dart';
import 'package:cloudmate/src/ui/home/widgets/bottom_sheet_attendance.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class AttendanceInPost extends StatefulWidget {
  final RoadMapContentModel roadMapContent;
  final int quantityMembers;
  final bool isAdmin;
  AttendanceInPost(
      {required this.roadMapContent, required this.isAdmin, required this.quantityMembers});
  @override
  State<StatefulWidget> createState() => _ExamInPostCard();
}

class _ExamInPostCard extends State<AttendanceInPost> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('attendances')
            .where('roadmapContentId', isEqualTo: widget.roadMapContent.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<QueryDocumentSnapshot> usersAttendance = snapshot.data?.docs ?? [];

          int indexOfAttendance = usersAttendance.indexWhere(
            (user) => user['userId'] == AppBloc.authBloc.userModel?.id,
          );

          bool isAttendance = indexOfAttendance != -1;

          return GestureDetector(
            onTap: () async {
              if (widget.isAdmin) {
                // Show dialog
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => BottomSheetAttendance(
                    title: '${usersAttendance.length}/${widget.quantityMembers}',
                    roadmapContentId: widget.roadMapContent.id,
                  ),
                );
              } else if (!isAttendance) {
                await AttendanceFirestore().createAttendance(widget.roadMapContent.id);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
              padding: EdgeInsets.all(12.5.sp),
              decoration: AppDecoration.buttonActionBorderActive(context, 10.sp).decoration,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Điểm danh: ' +
                              DateFormat('dd/MM/yyyy').format(widget.roadMapContent.endTime),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            color: isAttendance ? colorAttendance : colorDarkGrey,
                            fontFamily: FontFamily.lato,
                          ),
                        ),
                        SizedBox(height: 6.sp),
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.clockClockwise,
                              size: 15.sp,
                            ),
                            SizedBox(width: 6.sp),
                            Text(
                              DateFormat('HH:mm - dd/MM/yyyy').format(
                                widget.roadMapContent.endTime,
                              ),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.sp),
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.user,
                              size: 15.sp,
                            ),
                            SizedBox(width: 6.sp),
                            Text(
                              '${usersAttendance.length}/${widget.quantityMembers}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 32.sp,
                    width: 32.sp,
                    decoration: BoxDecoration(
                      color: isAttendance ? colorAttendance : colorDarkGrey,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIcons.handPalm,
                      color: mC,
                      size: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
