part of 'do_exam_bloc.dart';

@immutable
abstract class DoExamState {}

class DoExamInitial extends DoExamState {}

class InLobby extends DoExamState {
  final List<UserModel> users;
  InLobby({required this.users});
}

class DoExamLoading extends DoExamState {}

class DoingQuestion extends DoExamState {
  final QuestionModel? question;
  final int ping;
  DoingQuestion({this.question, required this.ping});
}

class ShowStatistic extends DoExamState {
  final StatisticModel statistic;
  ShowStatistic({required this.statistic});
}

class FinishStatistic extends DoExamState {
  final FinalStatisticModel statistic;
  FinishStatistic({required this.statistic});
}
