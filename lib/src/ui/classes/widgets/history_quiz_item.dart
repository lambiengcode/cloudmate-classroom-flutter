import 'package:cloudmate/src/helpers/export_excel.dart';
import 'package:cloudmate/src/models/history_quiz_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/remote/history_quiz_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

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
                        height: 32.sp,
                        width: 32.sp,
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
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.lato,
                                color: colorPrimary,
                              ),
                            ),
                            SizedBox(height: 2.sp),
                            Text(
                              'Tổng Điểm: ${widget.historyQuizModel.score}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.lato,
                                  ),
                            ),
                            SizedBox(height: 2.sp),
                            Text(
                              'Ngày kiểm tra: ${DateFormat('HH:mm - dd/MM/yyyy').format(widget.historyQuizModel.createdAt)}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 11.sp,
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
                  onPressed: () async {
                    showDialogLoading(context);
                    List<UserModel>? users = await HistoryQuizRepository()
                        .getDetailsHistory(quizId: widget.historyQuizModel.id);
                    AppNavigator.pop();
                    exportResultToExcel(users, widget.historyQuizModel.score);
                  },
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
