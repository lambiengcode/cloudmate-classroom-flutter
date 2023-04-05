import 'dart:async';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/question_type_enum.dart';
import 'package:cloudmate/src/models/statistic_model.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/common/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class StatisticInExamScreen extends StatefulWidget {
  final StatisticModel statisticModel;
  StatisticInExamScreen({required this.statisticModel});
  @override
  State<StatefulWidget> createState() => _StatisticInExamScreenState();
}

class _StatisticInExamScreenState extends State<StatisticInExamScreen> {
  late DoExamBloc _doExamBloc;
  Timer? _timmerInstance;
  int time = 3;
  String answer = "";
  List<double> percents = [];
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    startTimmer();
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

    if (AppBloc.doExamBloc.currentQuestion?.type == QuestionType.dragAndDrop) {
      isVisible = false;
    }
  }

  @override
  void dispose() {
    if (_timmerInstance != null) {
      if (_timmerInstance!.isActive) {
        _timmerInstance!.cancel();
      }
    }
    super.dispose();
  }

  void startTimmer() {
    var oneSec = Duration(seconds: 1);
    _timmerInstance = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (time <= 0) {
            _timmerInstance!.cancel();
          } else {
            time--;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        automaticallyImplyLeading: false,
        title: Text(
          'Thống kê',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _doExamBloc.add(QuitQuizEvent()),
            icon: Icon(
              PhosphorIcons.signOut,
              size: 20.sp,
              color: colorHigh,
            ),
          )
        ],
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
                child: Visibility(
                  visible: isVisible,
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
              ),
              Container(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.sp),
                    Text(
                      'Tiếp tục trong',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.75),
                        fontFamily: FontFamily.lato,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.sp),
                    Text(
                      '$time',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: FontFamily.lato,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      'giây nữa',
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
