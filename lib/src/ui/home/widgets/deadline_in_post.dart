import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/resources/hard/hard_schedule.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/app_decorations.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class DeadlineInPost extends StatefulWidget {
  final ScheduleDeadline deadline;
  DeadlineInPost({required this.deadline});
  @override
  State<StatefulWidget> createState() => _ExamInPostCard();
}

class _ExamInPostCard extends State<DeadlineInPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      padding: EdgeInsets.all(12.5.sp),
      decoration: AppDecoration.buttonActionBorder(context, 6.sp).decoration,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.deadline.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: colorHigh,
                    fontFamily: FontFamily.lato,
                  ),
                ),
                SizedBox(height: 6.sp),
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.clock,
                      size: 15.sp,
                    ),
                    SizedBox(width: 6.sp),
                    Text(
                      DateFormat('HH:mm aa - dd/MM/yyyy').format(
                        widget.deadline.deadline,
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
                      PhosphorIcons.folderNotchOpen,
                      size: 15.sp,
                    ),
                    SizedBox(width: 6.sp),
                    Text(
                      widget.deadline.fileName == ''
                          ? 'Chưa nộp'
                          : widget.deadline.fileName,
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
              color: widget.deadline.fileName == '' ? colorHigh : colorDarkGrey,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.folderNotchOpenFill,
              size: 15.sp,
              color: mC,
            ),
          ),
        ],
      ),
    );
  }
}
