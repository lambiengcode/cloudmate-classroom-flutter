import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class AttendanceInPost extends StatefulWidget {
  final RoadMapContentModel roadMapContent;
  AttendanceInPost({required this.roadMapContent});
  @override
  State<StatefulWidget> createState() => _ExamInPostCard();
}

class _ExamInPostCard extends State<AttendanceInPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Điểm danh: ' + DateFormat('dd/MM/yyyy').format(widget.roadMapContent.startTime),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: colorAttendance,
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
                      '10/15',
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
              color: colorAttendance,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            alignment: Alignment.center,
            child: Icon(
              FontAwesome5Solid.hand_paper,
              color: mC,
              size: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
