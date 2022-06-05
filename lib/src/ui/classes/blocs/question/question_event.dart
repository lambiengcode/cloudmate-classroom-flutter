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
  final File? banner;
  final File? audio;
  final QuestionType type;

  CreateQuestionEvent({
    required this.answers,
    required this.context,
    required this.corrects,
    required this.duration,
    required this.examId,
    required this.question,
    required this.score,
    required this.banner,
    required this.audio,
    required this.type,
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
  final File? banner;

  UpdateQuestionEvent({
    required this.answers,
    required this.context,
    required this.corrects,
    required this.duration,
    required this.question,
    required this.questionId,
    required this.score,
    required this.banner,
  });
}

class DeleteQuestionEvent extends QuestionEvent {
  final BuildContext context;
  final String questionId;
  DeleteQuestionEvent({required this.questionId, required this.context});
}

class ImportQuestionsEvent extends QuestionEvent {
  final BuildContext context;
  final String examId;
  final List<QuestionModel> questions;
  ImportQuestionsEvent({required this.context, required this.examId, required this.questions});
}
