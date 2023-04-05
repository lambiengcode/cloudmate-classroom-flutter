import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class LoadingScreen extends StatelessWidget {
  final bool isShowText;
  const LoadingScreen({this.isShowText = true});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isShowText ? 70.w : 50.w,
              height: isShowText ? 70.w : 50.w,
              child: Constants().loadingLottie,
            ),
            isShowText
                ? RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Load',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.dancing,
                            color: colorPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'ing',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.dancing,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
