import 'package:cloudmate/src/models/history_quiz_model.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class HistoryQuizCard extends StatefulWidget {
  final int index;
  final bool isLast;
  final HistoryQuizModel historyQuizModel;
  const HistoryQuizCard({
    required this.index,
    required this.historyQuizModel,
    this.isLast = false,
  });
  @override
  State<StatefulWidget> createState() => _HistoryQuizCardState();
}

class _HistoryQuizCardState extends State<HistoryQuizCard> {
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
                              widget.historyQuizModel.title,
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
                              widget.historyQuizModel.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                    PhosphorIcons.export,
                    size: 20.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => null,
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
}
