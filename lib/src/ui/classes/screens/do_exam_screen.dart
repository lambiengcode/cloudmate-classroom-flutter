import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class DoExamScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoExamScreenState();
}

class _DoExamScreenState extends State<DoExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(height: 12.sp),
              _buildHeader(context),
              SizedBox(height: 20.sp),
              LinearPercentIndicator(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                width: 100.w,
                lineHeight: 10.5.sp,
                percent: 0.65,
                backgroundColor: ThemeService().isSavedDarkMode()
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                progressColor: colorPrimary,
              ),
              SizedBox(height: 5.sp),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeText(context, '25', color: colorPrimary),
                    _buildTimeText(
                      context,
                      '40',
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.75),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.sp),
              Container(
                width: 100.w,
                child: Text(
                  '1. Ưu điểm của Flutter là gì?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.lato,
                  ),
                ),
              ),
              SizedBox(height: 16.sp),
              _buildAnswerOption(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildOptionHeader(
                context,
                '1/20',
                PhosphorIcons.question,
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.85),
              ),
              SizedBox(width: 12.sp),
              _buildOptionHeader(
                context,
                '20ms',
                Feather.bar_chart,
                colorAttendance,
              ),
            ],
          ),
          _buildOptionHeader(
            context,
            'Thoát',
            null,
            colorHigh,
            handlePressed: () {
              AppNavigator.pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionHeader(context, title, icon, color,
      {Function? handlePressed}) {
    return GestureDetector(
      onTap: () {
        if (handlePressed != null) {
          handlePressed();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon == null
                ? SizedBox()
                : Icon(
                    icon,
                    color: color,
                    size: 18.sp,
                  ),
            SizedBox(width: 6.sp),
            Padding(
              padding: EdgeInsets.only(top: 2.sp),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.lato,
                  color: color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimeText(context, title, {color}) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 13.25.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.lato,
      ),
    );
  }

  Widget _buildAnswerOption(context) {
    return Expanded(child: Container());
  }
}
