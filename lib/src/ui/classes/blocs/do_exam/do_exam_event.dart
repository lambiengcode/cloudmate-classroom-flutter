part of 'do_exam_bloc.dart';

@immutable
abstract class DoExamEvent {}

class CreateQuizEvent extends DoExamEvent {
  final String examId;
  CreateQuizEvent({required this.examId});
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

class TakeQuestionEvent extends DoExamEvent {
  final QuestionModel question;
  TakeQuestionEvent({required this.question});
}

class LeaveQuizEvent extends DoExamEvent {}

class FinishQuizEvent extends DoExamEvent {}

class StartPingEvent extends DoExamEvent {}

class EndPingEvent extends DoExamEvent {}
