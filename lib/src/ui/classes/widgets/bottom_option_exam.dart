import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/ui/classes/blocs/exam/exam_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_confirm.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class BottomOptionExam extends StatefulWidget {
  final ExamModel examModel;
  final ExamBloc examBloc;
  BottomOptionExam({required this.examModel, required this.examBloc});
  @override
  State<StatefulWidget> createState() => _BottomOptionExamState();
}

class _BottomOptionExamState extends State<BottomOptionExam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.sp),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: 35.w),
              decoration: AppDecoration.buttonActionBorder(context, 30.sp).decoration,
            ),
            SizedBox(height: 8.0),
            _buildAction(context, 'Chỉnh sửa bộ đề', PhosphorIcons.pencil),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(context, 'Xoá bộ đề', PhosphorIcons.trashSimple),
            SizedBox(height: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Chỉnh sửa bộ đề':
            AppNavigator.pop();
            AppNavigator.push(AppRoutes.CREATE_EXAM, arguments: {
              'classId': '',
              'examBloc': widget.examBloc,
              'examModel': widget.examModel,
            });
            break;
          case 'Xoá bộ đề':
            dialogAnimationWrapper(
              context: context,
              slideFrom: 'left',
              child: DialogConfirm(
                handleConfirm: () {
                  showDialogLoading(context);
                  widget.examBloc.add(
                    DeleteExamEvent(context: context, examId: widget.examModel.id),
                  );
                },
                subTitle: 'Sau khi xoá bộ đề bạn sẽ không thể khôi phục lại dữ liệu này',
                title: 'Xoá bộ đề',
              ),
            );
            break;
          default:
            break;
        }
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade800
                      : Colors.white,
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade800
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
