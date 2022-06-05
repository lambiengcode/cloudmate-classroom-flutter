part of 'do_exam_bloc.dart';

@immutable
abstract class DoExamEvent {}

class CreateQuizEvent extends DoExamEvent {
  final String examId;
  final String classId;
  final String title;
  final String description;
  CreateQuizEvent({
    required this.examId,
    required this.classId,
    required this.title,
    required this.description,
  });
}

class CreateQuizSuccessEvent extends DoExamEvent {
  final String roomId;
  CreateQuizSuccessEvent({required this.roomId});
}

class StartQuizEvent extends DoExamEvent {}

class JoinQuizEvent extends DoExamEvent {
  final String roomId;

  JoinQuizEvent({required this.roomId});
}

class JoinQuizSuccessEvent extends DoExamEvent {
  final List<UserModel> users;

  JoinQuizSuccessEvent({required this.users});
}

class NewUserJoined extends DoExamEvent {
  final UserModel user;
  NewUserJoined({required this.user});
}

class LeaveUserJoined extends DoExamEvent {
  final String userId;
  LeaveUserJoined({required this.userId});
}

class UpdateStatisticEvent extends DoExamEvent {
  final StatisticModel statistic;
  UpdateStatisticEvent({required this.statistic});
}

class AnswerQuestionEvent extends DoExamEvent {
  final String answer;
  AnswerQuestionEvent({required this.answer});
}

class SubmitAnswerDaDEvent extends DoExamEvent {
  final List<int> answers;
  SubmitAnswerDaDEvent({required this.answers});
}

class TakeQuestionEvent extends DoExamEvent {
  final QuestionModel question;
  final String indexQuestion;
  TakeQuestionEvent({required this.question, required this.indexQuestion});
}

class FinishQuizEvent extends DoExamEvent {
  final FinalStatisticModel finalStatistic;
  FinishQuizEvent({required this.finalStatistic});
}

class QuitQuizEvent extends DoExamEvent {}

class StartPingEvent extends DoExamEvent {}

class EndPingEvent extends DoExamEvent {}
