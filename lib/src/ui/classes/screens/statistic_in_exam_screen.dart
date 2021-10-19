import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/common/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class StatisticInExamScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticInExamScreenState();
}

class _StatisticInExamScreenState extends State<StatisticInExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => AppNavigator.pop(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Thống kê',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.5.sp),
              Divider(
                height: .25,
                thickness: .25,
              ),
              SizedBox(height: 6.sp),
              Container(
                height: 40.h,
                width: 100.w,
                child: PieChartRevenue(
                  data: [0.35, 0.3, 0.2, 0.15],
                ),
              ),
              Divider(
                height: .3,
                thickness: .3,
              ),
              SizedBox(height: 20.sp),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLineStatistic(context, '26% luc chon dap an A'),
                      _buildLineStatistic(context, '26% luc chon dap an B'),
                      _buildLineStatistic(context, '26% luc chon dap an C'),
                      _buildLineStatistic(context, '26% luc chon dap an D'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.sp),
                    Text(
                      'Start in',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.75),
                        fontFamily: FontFamily.lato,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.sp),
                    Text(
                      '3',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: FontFamily.lato,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      'seconds',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: FontFamily.lato,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6.sp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineStatistic(context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Text(
        '•  $text',
        style: TextStyle(
          fontSize: 13.75.sp,
          fontFamily: FontFamily.lato,
        ),
      ),
    );
  }
}
