import 'package:cloudmate/src/helpers/int.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/classes/blocs/question/question_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/bottom_option_question.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class QuestionCard extends StatefulWidget {
  final QuestionModel question;
  final QuestionBloc questionBloc;
  final bool isLast;
  final int index;
  final String examId;
  QuestionCard({
    required this.question,
    this.isLast = false,
    required this.index,
    required this.questionBloc,
    required this.examId,
  });
  @override
  State<StatefulWidget> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.sp),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 30.sp,
                        width: 30.sp,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.index}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.lato,
                            color: mC,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.sp),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.question.question,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.lato,
                                color: colorPrimary,
                              ),
                            ),
                            SizedBox(height: 3.5.sp),
                            Text(
                              'Thời gian trả lời: ' + widget.question.duration.formatTwoDigits(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.lato,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    PhosphorIcons.dotsThreeVerticalBold,
                    size: 20.sp,
                  ),
                  onPressed: () => _showBottomSheetSettings(context),
                ),
              ],
            ),
          ),
          widget.isLast
              ? Container()
              : Divider(
                  thickness: .2,
                  height: .2,
                  indent: 14.w,
                  endIndent: 12.0,
                ),
        ],
      ),
    );
  }

  void _showBottomSheetSettings(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomOptionQuestion(
          questionBloc: widget.questionBloc,
          questionModel: widget.question,
          examId: widget.examId,
        );
      },
    );
  }
}
