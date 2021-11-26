part of 'history_quiz_bloc.dart';

@immutable
abstract class HistoryQuizState {}

class HistoryQuizInitial extends HistoryQuizState {}

class GettingHistoryQuiz extends HistoryQuizState {}

class GetDoneHistoryQuiz extends HistoryQuizState {
  final List<HistoryQuizModel> quizs;
  GetDoneHistoryQuiz(this.quizs);
}
