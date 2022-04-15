part of 'share_exam_bloc.dart';

@immutable
abstract class ShareExamState {}

class ShareExamInitial extends ShareExamState {}

class GetDoneShareExam extends ShareExamState {
  final List<ExamModel> exams;
  GetDoneShareExam({required this.exams});
}
