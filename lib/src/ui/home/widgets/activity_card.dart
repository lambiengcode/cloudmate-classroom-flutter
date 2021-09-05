import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/models/activity.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/app_decorations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ActivityCard extends StatefulWidget {
  final Activity? activity;
  ActivityCard({this.activity});
  @override
  State<StatefulWidget> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.sp,
      margin: EdgeInsets.only(right: 12.sp),
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: AppDecoration.buttonActionBorder(context, 16.sp).decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIcons.checkSquareOffset,
                size: 25.sp,
                color: colorHigh,
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Course:\t',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: widget.activity!.title,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: colorHigh,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.sp),
          Row(
            children: [
              Icon(
                PhosphorIcons.calendarBlank,
                size: 14.sp,
              ),
              SizedBox(width: 4.sp),
              Text(
                ':\t20/09/2021',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
