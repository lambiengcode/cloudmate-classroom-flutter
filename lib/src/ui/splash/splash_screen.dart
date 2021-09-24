import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            child: Lottie.asset('assets/lottie/splash.json'),
          ),
          SizedBox(height: 16.sp),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: 'Cloud',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.dancing,
                  color: colorPrimary,
                ),
              ),
              TextSpan(
                text: 'mate',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.dancing,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
