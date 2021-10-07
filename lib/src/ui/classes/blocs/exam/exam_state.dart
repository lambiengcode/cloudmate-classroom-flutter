part of 'exam_bloc.dart';

@immutable
abstract class ExamState {
  List<dynamic> get props => [];
}

class ExamInitial extends ExamState {}

class GettingExamState extends ExamState {
  final List<ExamModel> listExam;
  final bool isOver;
  GettingExamState({required this.listExam, required this.isOver});

  @override
  List get props => [listExam, isOver];
}

class GetExamDoneState extends ExamState {
  final List<ExamModel> listExam;
  final bool isOver;
  GetExamDoneState({required this.listExam, required this.isOver});

  @override
  List get props => [listExam, isOver];
}
