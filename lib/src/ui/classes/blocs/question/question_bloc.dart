import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/question_type_enum.dart';
import 'package:cloudmate/src/resources/remote/question_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial());

  List<QuestionModel> listQuestion = [];
  int skip = 0;
  bool isOverQuestion = false;

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is GetListQuestionEvent) {
      if (listQuestion.isEmpty) {
        yield QuestionInitial();
      } else {
        yield GettingQuestion(
          listQuestion: listQuestion,
          isOver: isOverQuestion,
        );
      }
      await _getListQuestion(
        id: event.examId,
      );
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
    }

    if (event is CreateQuestionEvent) {
      bool isCreateSuccess = await _createQuestion(
        question: event.question,
        examId: event.examId,
        answers: event.answers,
        corrects: event.corrects,
        duration: event.duration,
        score: event.score,
        image: event.banner,
        audio: event.audio,
        type: event.type,
      );
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );

      if (isCreateSuccess) {
        AppNavigator.popUntil(AppRoutes.LIST_QUESTION);
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Tạo câu hỏi thất bại, vui lòng thử lại sau',
        );
      }
    }

    if (event is UpdateQuestionEvent) {
      bool isUpdateSuccess = await _editQuestion(
        question: event.question,
        questionId: event.questionId,
        answers: event.answers,
        corrects: event.corrects,
        duration: event.duration,
        score: event.score,
      );
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
      if (isUpdateSuccess) {
        AppNavigator.pop();
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Bạn đã chỉnh sửa thành công',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Chỉnh sửa thất bại, vui lòng thử lại sau',
        );
      }
    }

    if (event is DeleteQuestionEvent) {
      bool isDeleteSuccess = await _deleteQuestion(questionId: event.questionId);
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
      if (isDeleteSuccess) {
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Bạn đã xoá câu hỏi thành công',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Xoá thất bại, hãy thử lại sau!',
        );
      }
    }

    if (event is ImportQuestionsEvent) {
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
      bool isImportSuccess = await _importQuestions(
        examId: event.examId,
        questions: event.questions,
      );
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
      if (isImportSuccess) {
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Bạn đã import thành công',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Import thất bại, vui lòng thử lại sau',
        );
      }
    }
  }

  // MARK: - Event handler function

  Future<void> _getListQuestion({
    required String id,
  }) async {
    List<QuestionModel> questions = await QuestionRepository().getListQuestion(
      skip: skip,
      id: id,
    );

    if (questions.isEmpty) {
      isOverQuestion = true;
    } else {
      skip += questions.length;
      listQuestion.addAll(questions);
    }
  }

  Future<bool> _importQuestions(
      {required String examId, required List<QuestionModel> questions}) async {
    List<QuestionModel> questionsResponse = await QuestionRepository().importQuestions(
      examId: examId,
      questions: questions,
    );
    AppNavigator.pop();
    if (questionsResponse.isNotEmpty) {
      listQuestion.addAll(questionsResponse);
    }

    return questionsResponse.isNotEmpty;
  }

  Future<bool> _createQuestion({
    required String question,
    required String examId,
    required List<String> answers,
    required List<int> corrects,
    required int duration,
    required int score,
    required File? image,
    required File? audio,
    required QuestionType type,
  }) async {
    QuestionModel? questionModel = await QuestionRepository().createQuestion(
      question: question,
      examId: examId,
      answers: answers,
      corrects: corrects,
      duration: duration,
      score: score,
      banner: image,
      audio: audio,
      type: type,
    );
    AppNavigator.pop();
    if (questionModel != null) {
      listQuestion.add(questionModel);
    }

    return questionModel != null;
  }

  Future<bool> _editQuestion({
    required String question,
    required String questionId,
    required List<String> answers,
    required List<int> corrects,
    required int duration,
    required int score,
  }) async {
    QuestionModel? questionModel = await QuestionRepository().editQuestion(
      question: question,
      answers: answers,
      duration: duration,
      questionId: questionId,
      correct: corrects,
      score: score,
    );
    AppNavigator.pop();
    if (questionModel != null) {
      int index = listQuestion.indexWhere((item) => item.id == questionModel.id);
      if (index != -1) {
        listQuestion[index] = questionModel;
      }
    }

    return questionModel != null;
  }

  Future<bool> _deleteQuestion({
    required String questionId,
  }) async {
    bool isDeleteSuccess = await QuestionRepository().deleteQuestion(questionId: questionId);
    AppNavigator.popUntil(AppRoutes.LIST_QUESTION);
    if (isDeleteSuccess) {
      int index = listQuestion.indexWhere((item) => item.id == questionId);
      if (index != -1) {
        listQuestion.removeAt(index);
      }
    }

    return isDeleteSuccess;
  }

  void _showDialogResult(
    context, {
    String title = 'Thành công',
    String subTitle = 'Chúc mừng bạn đã tạo câu hỏi thành công',
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
