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
  List<String> _answers = ['A đúng', 'B đúng', 'C đúng', 'Tất cả đều đúng'];
  List<Color> _colors = [
    colorPrimary,
    colorHigh,
    Colors.green,
    Colors.deepPurpleAccent.shade200,
    Colors.pinkAccent.shade100,
  ];

  @override
  void initState() {
    super.initState();
    _colors.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(
          PhosphorIcons.lockFill,
          size: 20.sp,
          color: mC,
        ),
        backgroundColor: colorPrimary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                lineHeight: 6.sp,
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
              SizedBox(height: 20.sp),
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Text(
                  'Ưu điểm của Flutter là gì? Ưu điểm của Flutter là gì?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.lato,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.85),
                  ),
                ),
              ),
              SizedBox(height: 24.sp),
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
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _answers.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 13.75.sp,
              vertical: 6.sp,
            ),
            padding: EdgeInsets.symmetric(vertical: 15.25.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              color: _colors[index % (_colors.length)],
            ),
            alignment: Alignment.center,
            child: Text(
              _answers[index],
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.lato,
                color: mC,
              ),
            ),
          );
        },
      ),
    );
  }
}
