import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class GetSnackBar {
  final String title;
  final String subTitle;
  GetSnackBar({
    required this.title,
    required this.subTitle,
  });

  show() {
    Get.snackbar(
      '',
      '',
      onTap: (obj) {},
      colorText: Colors.white,
      backgroundColor: Colors.black45,
      duration: Duration(
        milliseconds: 1500,
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        subTitle,
        style: TextStyle(
          fontSize: 10.5.sp,
          color: Colors.white.withOpacity(.85),
          fontWeight: FontWeight.w400,
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        16.sp,
        16.sp,
        6.sp,
        14.sp,
      ),
    );
  }
}
