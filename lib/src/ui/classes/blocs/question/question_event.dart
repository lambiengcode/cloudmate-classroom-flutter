part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}

class GetListQuestionEvent extends QuestionEvent {
  final String examId;
  GetListQuestionEvent({required this.examId});
}

class CreateQuestionEvent extends QuestionEvent {
  final BuildContext context;
  final String examId;
  final int duration;
  final List<int> corrects;
  final List<String> answers;
  final String question;
  final int score;

  CreateQuestionEvent({
    required this.answers,
    required this.context,
    required this.corrects,
    required this.duration,
    required this.examId,
    required this.question,
    required this.score,
  });
}

class UpdateQuestionEvent extends QuestionEvent {
  final BuildContext context;
  final int duration;
  final List<int> corrects;
  final List<String> answers;
  final String question;
  final String questionId;
  final int score;

  UpdateQuestionEvent({
    required this.answers,
    required this.context,
    required this.corrects,
    required this.duration,
    required this.question,
    required this.questionId,
    required this.score,
  });
}

class DeleteQuestionEvent extends QuestionEvent {
  final BuildContext context;
  final String questionId;
  DeleteQuestionEvent({required this.questionId, required this.context});
}
