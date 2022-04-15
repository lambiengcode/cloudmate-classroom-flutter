import 'package:cloudmate/src/models/notification_model.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  NotificationCard({required this.notification});
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
                  widget.notification.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.lato,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.sp),
                Text(
                  widget.notification.description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.lato,
                  ),
                ),
                SizedBox(height: 4.sp),
                Text(
                  DateFormat('HH:mm - dd/MM/yyyy').format(widget.notification.createdAt),
                  style: TextStyle(
                    fontSize: 11.25.sp,
                    fontFamily: FontFamily.lato,
                    fontWeight: FontWeight.w600,
                    color: colorPrimary,
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
