import 'package:cloudmate/src/models/statistic_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/common/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class StatisticFinalScreen extends StatefulWidget {
  final StatisticModel statisticModel;
  StatisticFinalScreen({required this.statisticModel});
  @override
  State<StatefulWidget> createState() => _StatisticFinalScreenState();
}

class _StatisticFinalScreenState extends State<StatisticFinalScreen> {
  late DoExamBloc _doExamBloc;
  String answer = "";
  List<double> percents = [];

  @override
  void initState() {
    super.initState();
    _doExamBloc = BlocProvider.of<DoExamBloc>(context);
    int total = widget.statisticModel.chooses.reduce((value, element) => value + element);
    double totalPercent = 0.0;
    widget.statisticModel.chooses.asMap().forEach((index, item) {
      if (index == widget.statisticModel.chooses.length - 1) {
        percents.add(1.0 - totalPercent);
      } else {
        percents.add(item / total);
        totalPercent += item / total;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => _doExamBloc.add(LeaveQuizEvent()),
          icon: Icon(
            PhosphorIcons.signOut,
            size: 20.sp,
            color: colorHigh,
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
                height: 38.h,
                width: 100.w,
                child: PieChartRevenue(
                  data: percents,
                  labels: widget.statisticModel.answers,
                ),
              ),
              Divider(
                height: .3,
                thickness: .3,
              ),
              SizedBox(height: 20.sp),
              Expanded(
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(
                        widget.statisticModel.answers.length,
                        (index) => _buildLineStatistic(
                          context,
                          widget.statisticModel.chooses[index],
                          widget.statisticModel.answers[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineStatistic(context, int quantityPicked, String answer) {
    String title = '• $quantityPicked người lựa chọn đáp án $answer';
    if (answer == 'null') {
      title = '• $quantityPicked người không chọn đáp án';
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13.75.sp,
          fontFamily: FontFamily.lato,
        ),
      ),
    );
  }
}
