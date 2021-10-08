part of 'question_bloc.dart';

@immutable
abstract class QuestionState {
  List<dynamic> get props => [];
}

class QuestionInitial extends QuestionState {}

class GettingQuestion extends QuestionState {
  final List<QuestionModel> listQuestion;
  final bool isOver;
  GettingQuestion({required this.listQuestion, required this.isOver});

  @override
  List get props => [listQuestion];
}

class GetDoneQuestion extends QuestionState {
  final List<QuestionModel> listQuestion;
  final bool isOver;
  GetDoneQuestion({required this.listQuestion, required this.isOver});

  @override
  List get props => [listQuestion];
}
