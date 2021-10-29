part of 'do_exam_bloc.dart';

@immutable
abstract class DoExamState {}

class DoExamInitial extends DoExamState {}

class InLobby extends DoExamState {}

class DoExamLoading extends DoExamState {}

class DoingQuestion extends DoExamState {
  final QuestionModel question;
  DoingQuestion({required this.question});
}

class ShowStatistic extends DoExamState {
  final StatisticModel statistic;
  ShowStatistic({required this.statistic});
}

class FinishStatistic extends DoExamState {
  final StatisticModel statistic;
  FinishStatistic({required this.statistic});
}
