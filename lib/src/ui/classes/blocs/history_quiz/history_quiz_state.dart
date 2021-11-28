part of 'history_quiz_bloc.dart';

@immutable
abstract class HistoryQuizState {
  List<dynamic> get props => [];
}

class HistoryQuizInitial extends HistoryQuizState {}

class GetDoneHistoryQuiz extends HistoryQuizState {
  final List<HistoryQuizModel> quizs;
  GetDoneHistoryQuiz(this.quizs);

  @override
  List get props => [quizs];
}
