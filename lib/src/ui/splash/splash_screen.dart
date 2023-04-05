import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.w,
                    height: 100.w,
                    child: Constants().splashLottie,
                  ),
                  SizedBox(height: 16.sp),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Cloud',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.dancing,
                          color: colorPrimary,
                        ),
                      ),
                      TextSpan(
                        text: 'mate',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.dancing,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
            Text(
              '@${DateTime.now().year} Cloudmate copyright',
              style: TextStyle(
                fontSize: 7.sp,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.sp),
          ],
        ),
      ),
    );
  }
}
