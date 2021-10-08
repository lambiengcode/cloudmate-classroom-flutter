import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/resources/remote/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
      await _getListQuestion();
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
    }

    if (event is CreateQuestionEvent) {
      await _createQuestion(
        question: event.question,
        examId: event.examId,
        answers: event.answers,
        corrects: event.corrects,
        duration: event.duration,
      );
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
    }

    if (event is UpdateQuestionEvent) {
      await _editQuestion(
        question: event.question,
        questionId: event.questionId,
        answers: event.answers,
        corrects: event.corrects,
        duration: event.duration,
      );
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
    }

    if (event is DeleteQuestionEvent) {
      await _deleteQuestion(questionId: event.questionId);
      yield GetDoneQuestion(
        listQuestion: listQuestion,
        isOver: isOverQuestion,
      );
    }
  }

  Future<void> _getListQuestion() async {
    List<QuestionModel> questions = await QuestionRepository().getListQuestion(skip: skip);

    if (questions.isEmpty) {
      isOverQuestion = true;
    } else {
      skip += questions.length;
      listQuestion.addAll(questions);
    }
  }

  Future<bool> _createQuestion({
    required String question,
    required String examId,
    required List<String> answers,
    required List<int> corrects,
    required int duration,
  }) async {
    QuestionModel? questionModel = await QuestionRepository().createQuestion(
      question: question,
      examId: examId,
      answers: answers,
      corrects: corrects,
      duration: duration,
    );

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
  }) async {
    QuestionModel? questionModel = await QuestionRepository().editQuestion(
      question: question,
      answers: answers,
      duration: duration,
      questionId: questionId,
      correct: corrects,
    );

    if (questionModel != null) {
      listQuestion.add(questionModel);
    }

    return questionModel != null;
  }

  Future<bool> _deleteQuestion({
    required String questionId,
  }) async {
    bool isDeleteSuccess = await QuestionRepository().deleteQuestion(questionId: questionId);

    if (isDeleteSuccess) {
      int index = listQuestion.indexWhere((item) => item.id == questionId);
      if (index != -1) {
        listQuestion.removeAt(index);
      }
    }

    return isDeleteSuccess;
  }
}
