import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 12.sp),
      child: Row(
        children: [
          Container(
            height: 48.sp,
            width: 48.sp,
            padding: EdgeInsets.all(1.25.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorPrimary,
                width: 2.sp,
              ),
            ),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000.sp),
                child: BlurHash(
                  hash: '',
                  image: Constants.urlImageDefault,
                  imageFit: BoxFit.cover,
                  color: colorPrimary,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This is notification in Cloudmate app. This is notification in Cloudmate application.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.lato,
                  ),
                ),
                SizedBox(height: 6.sp),
                Text(
                  '18 Oct, 2021',
                  style: TextStyle(
                    fontSize: 11.25.sp,
                    fontFamily: FontFamily.lato,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
