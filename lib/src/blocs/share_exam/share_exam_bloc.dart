import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/resources/remote/share_exam_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
part 'share_exam_event.dart';
part 'share_exam_state.dart';

class ShareExamBloc extends Bloc<ShareExamEvent, ShareExamState> {
  ShareExamBloc() : super(ShareExamInitial());

  List<ExamModel> exams = [];

  @override
  Stream<ShareExamState> mapEventToState(ShareExamEvent event) async* {
    if (event is GetShareExamEvent) {
      if (exams.isEmpty) {
        await _getExams();
        yield _getDoneShareExam;
      }
    }

    if (event is CreateShareExamEvent) {
      await _createExam(event);
      yield _getDoneShareExam;
    }
  }

  // MARK: Private methods
  GetDoneShareExam get _getDoneShareExam => GetDoneShareExam(exams: exams);

  Future<void> _getExams() async {
    List<ExamModel> _exams = await ShareExamRepository().getListExam();

    exams.addAll(_exams);
  }

  Future<void> _createExam(CreateShareExamEvent event) async {
    ExamModel? _exam = await ShareExamRepository().createExam(
      name: event.name,
      description: event.description,
    );

    AppNavigator.pop();

    if (_exam != null) {
      exams.add(_exam);
      AppNavigator.pop();
    } else {
      // Show dialog failure
    }
  }
}
