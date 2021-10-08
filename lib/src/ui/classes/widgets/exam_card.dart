import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ExamCard extends StatefulWidget {
  final ExamModel exam;
  final bool isLast;
  ExamCard({required this.exam, this.isLast = false});
  @override
  State<StatefulWidget> createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
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
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                IconButton(
                  icon: Icon(
                    PhosphorIcons.dotsThreeVerticalBold,
                    size: 20.sp,
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
