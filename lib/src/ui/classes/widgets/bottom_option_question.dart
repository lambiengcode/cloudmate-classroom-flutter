import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/ui/classes/blocs/question/question_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_confirm.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class BottomOptionQuestion extends StatefulWidget {
  final QuestionModel questionModel;
  final QuestionBloc questionBloc;
  final String examId;
  BottomOptionQuestion({
    required this.questionBloc,
    required this.questionModel,
    required this.examId,
  });
  @override
  State<StatefulWidget> createState() => _BottomOptionQuestionState();
}

class _BottomOptionQuestionState extends State<BottomOptionQuestion> {
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
            _buildAction(context, 'Chỉnh sửa câu hỏi', PhosphorIcons.pencil),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(context, 'Xoá câu hỏi', PhosphorIcons.trashSimple),
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
          case 'Chỉnh sửa câu hỏi':
            AppNavigator.pop();
            AppNavigator.push(AppRoutes.CREATE_QUESTION, arguments: {
              'examId': widget.examId.toString(),
              'questionBloc': widget.questionBloc,
              'questionModel': widget.questionModel,
            });

            // AppNavigator.push(AppRoutes.DO_EXAM, arguments: {
            //   'questionModel': widget.questionModel,
            //   'questionIndex': '1/1',
            // });
            break;
          case 'Xoá câu hỏi':
            dialogAnimationWrapper(
              context: context,
              slideFrom: 'left',
              child: DialogConfirm(
                handleConfirm: () {
                  showDialogLoading(context);
                  widget.questionBloc.add(
                    DeleteQuestionEvent(questionId: widget.questionModel.id, context: context),
                  );
                },
                subTitle: 'Sau khi xoá câu hỏi bạn sẽ không thể khôi phục lại dữ liệu này',
                title: 'Xoá câu hỏi',
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
