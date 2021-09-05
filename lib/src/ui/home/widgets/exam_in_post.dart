import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/app_decorations.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ExamInPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamInPostCard();
}

class _ExamInPostCard extends State<ExamInPost> {
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
                  'Kiểm tra tuần 5',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
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
                      '16:00 PM - 06/05/2021',
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
                      '45 phút',
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
            width: 62.sp,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            alignment: Alignment.center,
            child: Text(
              'Xem',
              style: TextStyle(
                color: mC,
                fontFamily: FontFamily.lato,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
