import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/resources/remote/exam_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamBloc() : super(ExamInitial());
  List<ExamModel> listExam = [];
  int skip = 0;
  bool isOverExam = false;

  @override
  Stream<ExamState> mapEventToState(ExamEvent event) async* {
    if (event is GetListExamEvent) {
      if (listExam.length == 0) {
        yield ExamInitial();
      } else {
        yield GettingExamState(listExam: listExam, isOver: isOverExam);
      }
      await _getListExam(classId: event.classId);
      yield GetExamDoneState(listExam: listExam, isOver: isOverExam);
    }

    if (event is CreateExamEvent) {
      bool isCreateSuccess = await _createExam(
        classId: event.classId,
        name: event.name,
        description: event.description,
      );
      yield GetExamDoneState(listExam: listExam, isOver: isOverExam);
      if (isCreateSuccess) {
        _showDialogResult(event.context);
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Tạo đề thất bại, thử lại sau!',
        );
      }
    }

    if (event is EditExamEvent) {
      bool isEditSuccess = await _editExam(
        examId: event.examId,
        name: event.name,
        description: event.description,
      );
      yield GetExamDoneState(listExam: listExam, isOver: isOverExam);
      if (isEditSuccess) {
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Bạn đã chỉnh sửa thông tin thành công',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Chỉnh sửa thất bại, thử lại sau!',
        );
      }
    }

    if (event is DeleteExamEvent) {
      bool isDeleteSuccess = await _deleteExam(examId: event.examId);
      yield GetExamDoneState(listExam: listExam, isOver: isOverExam);
      if (isDeleteSuccess) {
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Bạn đã xoá bộ đề thành công',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Xoá thất bại, hãy thử lại sau!',
        );
      }
    }
  }

  // MARK: - Event handler function

  Future<void> _getListExam({required String classId}) async {
    List<ExamModel> listExamResponse = await ExamRepository().getListExam(
      classId: classId,
      skip: skip,
    );
    if (listExamResponse.isEmpty) {
      isOverExam = true;
    } else {
      skip += listExamResponse.length;
      listExam.addAll(listExamResponse);
    }
  }

  Future<bool> _createExam({
    required String classId,
    required String name,
    required String description,
  }) async {
    ExamModel? examResponse = await ExamRepository().createExam(
      classId: classId,
      name: name,
      description: description,
    );

    AppNavigator.pop();

    if (examResponse == null) {
      return false;
    } else {
      AppNavigator.pop();
      skip++;
      listExam.add(examResponse);
      return true;
    }
  }

  Future<bool> _editExam({
    required String examId,
    required String name,
    required String description,
  }) async {
    ExamModel? examResponse =
        await ExamRepository().updateExam(examId: examId, name: name, description: description);
    AppNavigator.pop();
    if (examResponse == null) {
      return false;
    } else {
      AppNavigator.popUntil(AppRoutes.LIST_EXAM);
      int index = listExam.indexWhere((item) => item.id == examResponse.id);
      if (index != -1) {
        listExam[index] = examResponse;
      }
      return true;
    }
  }

  Future<bool> _deleteExam({required String examId}) async {
    bool isDeleteSuccess = await ExamRepository().deleteExam(examId: examId);
    AppNavigator.pop();
    AppNavigator.pop();
    if (isDeleteSuccess) {
      int index = listExam.indexWhere((item) => item.id == examId);
      if (index != -1) {
        listExam.removeAt(index);
      }
    }
    return isDeleteSuccess;
  }

  void _showDialogResult(
    context, {
    String title = 'Thành công',
    String subTitle = 'Chúc mừng bạn đã tạo bộ đề thành công',
  }) {
    dialogAnimationWrapper(
      dismissible: false,
      context: context,
      child: Container(
        width: 300.sp,
        height: 155.sp,
        padding: EdgeInsets.symmetric(vertical: 16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 6.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 10.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.5.sp),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.5.sp),
              ),
            ),
            SizedBox(height: 8.sp),
            Divider(),
            GestureDetector(
              onTap: () {
                AppNavigator.pop();
              },
              child: Container(
                color: Colors.transparent,
                width: 300.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
