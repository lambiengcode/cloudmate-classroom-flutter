import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/classes/blocs/exam/exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/bottom_option_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ExamCard extends StatefulWidget {
  final ExamModel exam;
  final bool isLast;
  final bool isPickedMode;
  final bool isShareCard;
  ExamCard({
    required this.exam,
    this.isLast = false,
    this.isPickedMode = false,
    this.isShareCard = false,
  });
  @override
  State<StatefulWidget> createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
  late ExamBloc _examBloc;

  @override
  void initState() {
    super.initState();
    if (!widget.isShareCard) {
      _examBloc = BlocProvider.of<ExamBloc>(context);
    }
  }

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.exam.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.lato,
                              color: colorPrimary,
                            ),
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            widget.exam.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.lato,
                                ),
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            'Đã sử dụng ${widget.exam.usedTimes} lần',
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
                    ],
                  ),
                ),
                widget.isPickedMode || widget.isShareCard
                    ? SizedBox()
                    : IconButton(
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
        return BottomOptionExam(
          examModel: widget.exam,
          examBloc: _examBloc,
        );
      },
    );
  }
}
