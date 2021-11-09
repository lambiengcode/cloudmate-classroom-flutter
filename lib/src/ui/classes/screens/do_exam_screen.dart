import 'dart:async';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:cloudmate/src/helpers/int.dart';

class DoExamScreen extends StatefulWidget {
  final QuestionModel questionModel;
  final String questionIndex;
  DoExamScreen({required this.questionModel, required this.questionIndex});
  @override
  State<StatefulWidget> createState() => _DoExamScreenState();
}

class _DoExamScreenState extends State<DoExamScreen> {
  List<Color> _colors = [
    colorPrimary,
    colorHigh,
    Colors.green,
    Colors.deepPurpleAccent.shade200,
    Colors.pinkAccent.shade100,
  ];
  Timer? _timmerInstance;
  int time = 0;
  String answer = "";

  @override
  void initState() {
    super.initState();
    startTimmer();
    _colors.shuffle();
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
          if (time >= widget.questionModel.duration) {
            _timmerInstance!.cancel();
          } else {
            time++;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DoExamBloc, DoExamState>(
        builder: (context, state) {
          if (state is DoingQuestion) {
            return SafeArea(
              child: Container(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    SizedBox(height: 12.sp),
                    _buildHeader(context, state.ping),
                    SizedBox(height: 20.sp),
                    LinearPercentIndicator(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      width: 100.w,
                      lineHeight: 6.sp,
                      percent: time / widget.questionModel.duration,
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
                          _buildTimeText(context, time.toString(), color: colorPrimary),
                          _buildTimeText(
                            context,
                            widget.questionModel.duration.toString(),
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.75),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 12.sp),
                      margin: EdgeInsets.symmetric(horizontal: 13.75.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorPrimary, width: 1.5.sp),
                        borderRadius: BorderRadius.circular(6.sp),
                      ),
                      child: Text(
                        widget.questionModel.question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.75.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.lato,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.85),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.sp),
                    _buildAnswerOption(context),
                  ],
                ),
              ),
            );
          }

          return LoadingScreen();
        },
      ),
    );
  }

  Widget _buildHeader(context, int ping) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildOptionHeader(
                context,
                widget.questionIndex,
                PhosphorIcons.question,
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.85),
              ),
              SizedBox(width: 12.sp),
              _buildOptionHeader(
                context,
                '$ping ms',
                Feather.bar_chart,
                ping.getColorByPing(),
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

  Widget _buildOptionHeader(context, title, icon, color, {Function? handlePressed}) {
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

  Widget _buildTimeText(context, String title, {Color? color}) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: color == colorPrimary ? 20.sp : 13.25.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.lato,
      ),
    );
  }

  Widget _buildAnswerOption(context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.questionModel.answers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (answer == '') {
                AppBloc.doExamBloc.add(
                  AnswerQuestionEvent(
                    answer: widget.questionModel.answers[index],
                  ),
                );

                setState(() {
                  answer = widget.questionModel.answers[index];
                });
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 13.75.sp,
                vertical: 6.sp,
              ),
              padding: EdgeInsets.symmetric(vertical: 15.25.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: answer == "" || answer == widget.questionModel.answers[index]
                    ? _colors[index % (_colors.length)]
                    : Colors.grey,
              ),
              alignment: Alignment.center,
              child: Text(
                widget.questionModel.answers[index],
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.lato,
                  color: mC,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
