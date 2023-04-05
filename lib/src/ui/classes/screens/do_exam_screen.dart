import 'dart:async';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/helpers/audio_helper.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/question_type_enum.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:cloudmate/src/helpers/int.dart';

class DoExamScreen extends StatefulWidget {
  final QuestionModel questionModel;
  final String questionIndex;
  DoExamScreen({required this.questionModel, required this.questionIndex});
  @override
  State<StatefulWidget> createState() => _DoExamScreenState();
}

class _DoExamScreenState extends State<DoExamScreen> {
  late DoExamBloc _doExamBloc;
  List<Color> _colors = [
    colorPrimary,
    colorHigh,
    Colors.green,
    Colors.deepPurpleAccent.shade200,
    Colors.pinkAccent.shade100,
  ];
  Timer? _timmerInstance;
  int time = 0;
  List<String> _anwsers = [];
  List<Map<String, String>> dragAndDrops = [];
  List<String> _keys = [];
  List<String> _values = [];
  List<int> _mAnswerDaD = [];

  @override
  void initState() {
    super.initState();
    if (widget.questionModel.audio != null) {
      AudioHelper().soundAndRing(widget.questionModel.audio!);
    }
    startTimmer();
    _doExamBloc = BlocProvider.of<DoExamBloc>(context);
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

            if (time == widget.questionModel.duration - 1 &&
                widget.questionModel.type == QuestionType.dragAndDrop) {
              AppBloc.doExamBloc.add(AnswerQuestionEvent(answer: _mAnswerDaD.join(',')));
            }
          }
        },
      ),
    );

    if (widget.questionModel.type == QuestionType.dragAndDrop) {
      widget.questionModel.answers.asMap().forEach((index, answer) {
        if (index < (widget.questionModel.answers.length / 2)) {
          dragAndDrops.add({
            'key': answer,
          });
        } else {
          dragAndDrops[index - (widget.questionModel.answers.length ~/ 2)]['value'] = answer;
        }
      });

      _keys = dragAndDrops.map((e) => e['key'].toString()).toList();
      _values = dragAndDrops.map((e) => e['value'].toString()).toList();

      _values.shuffle();
    }
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
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.75),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.questionModel.audio != null,
                      child: StreamBuilder<Duration>(
                        stream: AudioHelper.bufferedController.stream,
                        builder: (context, snapshot) {
                          int duration = snapshot.data?.inSeconds ?? (time + 1);

                          print(duration);

                          return Column(
                            children: [
                              Text(
                                'Audio',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12.sp),
                              LinearPercentIndicator(
                                padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                width: 100.w,
                                lineHeight: 6.sp,
                                percent: (time / duration) > 1.0 ? 1.0 : (time / duration),
                                backgroundColor: ThemeService().isSavedDarkMode()
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade300,
                                progressColor: colorMedium,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: widget.questionModel.banner != null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.sp),
                          Container(
                            height: 100.sp,
                            width: 100.w,
                            decoration: BoxDecoration(
                              image: widget.questionModel.banner == null
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(widget.questionModel.banner!),
                                      fit: BoxFit.fitHeight,
                                    ),
                            ),
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
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.85),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.sp),
                    widget.questionModel.type == QuestionType.dragAndDrop
                        ? _buildLayoutForDaD()
                        : _buildAnswerOption(context),
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
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.85),
              ),
              SizedBox(width: 12.sp),
              _buildOptionHeader(
                context,
                '$ping ms',
                PhosphorIcons.chartBar,
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
              _doExamBloc.add(QuitQuizEvent());
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
              if (_anwsers.indexOf(widget.questionModel.answers[index]) == -1) {
                if (widget.questionModel.type == QuestionType.multipleChoise) {
                  AppBloc.doExamBloc.add(
                    AnswerQuestionEvent(
                      answer: widget.questionModel.answers[index],
                    ),
                  );

                  setState(() {
                    _anwsers.add(widget.questionModel.answers[index]);
                  });
                } else {
                  if (_anwsers.isEmpty) {
                    AppBloc.doExamBloc.add(
                      AnswerQuestionEvent(
                        answer: widget.questionModel.answers[index],
                      ),
                    );

                    setState(() {
                      _anwsers.add(widget.questionModel.answers[index]);
                    });
                  }
                }
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
                color:
                    _anwsers.isEmpty || _anwsers.indexOf(widget.questionModel.answers[index]) != -1
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

  Widget _buildLayoutForDaD() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: Row(
        children: [
          _buildColumnLayoutDaD1(_keys),
          _buildColumnLayoutDaD2(_values),
        ],
      ),
    );
  }

  Widget _buildColumnLayoutDaD1(List<String> values) {
    return Expanded(
      child: Column(
        children: values
            .map(
              (e) => Draggable(
                child: _buildContainerDaD(value: e),
                feedback: _buildContainerDaD(value: e, color: colorPrimary),
                data: e,
                childWhenDragging: SizedBox(),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildColumnLayoutDaD2(List<String> values) {
    return Expanded(
      child: Column(
        children: values
            .map(
              (e) => DragTarget<String>(
                builder: (BuildContext context, List<String?> incoming, List rejected) {
                  return _buildContainerDaD(value: e);
                },
                onWillAccept: (data) => true,
                onAccept: (data) {
                  int indexOfKey = _keys.indexOf(data);
                  int indexOfValue = _values.indexOf(e);

                  _mAnswerDaD.add(dragAndDrops.indexWhere((dad) => dad['key'] == data) + 1);
                  _mAnswerDaD.add(dragAndDrops.indexWhere((dad) => dad['value'] == e) +
                      1 +
                      dragAndDrops.length);

                  setState(() {
                    _keys.removeAt(indexOfKey);
                    _values.removeAt(indexOfValue);
                  });
                },
                onLeave: (data) {},
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildContainerDaD({required String value, Color? color}) {
    return Material(
      elevation: 0.0,
      color: Colors.transparent,
      child: Container(
        width: 45.w,
        decoration: BoxDecoration(
          color: color ?? colorDarkGrey,
          borderRadius: BorderRadius.circular(4.sp),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        alignment: Alignment.center,
        child: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
