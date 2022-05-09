import 'package:flutter/material.dart';
import 'package:cloudmate/src/helpers/int.dart';
import 'package:cloudmate/src/resources/hard/hard_exam_post.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ExamInPost extends StatefulWidget {
  final Exam exam;
  ExamInPost({required this.exam});
  @override
  State<StatefulWidget> createState() => _ExamInPostCard();
}

class _ExamInPostCard extends State<ExamInPost> {
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
                  widget.exam.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: FontFamily.lato,
                    fontWeight: FontWeight.w600,
                    color: colorPrimary,
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
                      DateFormat('HH:mm - dd/MM/yyyy').format(
                        widget.exam.startTime,
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
                      PhosphorIcons.hourglassMedium,
                      size: 15.sp,
                    ),
                    SizedBox(width: 6.sp),
                    Text(
                      widget.exam.duration.formatTwoDigits(),
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
              color: colorPrimary,
              borderRadius: BorderRadius.circular(6.sp),
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.eye,
              color: mC,
              size: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
