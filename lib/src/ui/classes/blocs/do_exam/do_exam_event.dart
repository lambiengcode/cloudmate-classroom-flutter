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

class StartQuizEvent extends DoExamEvent {
  final String roomId;
  StartQuizEvent({required this.roomId});
}

class JoinQuizEvent extends DoExamEvent {
  final List<UserModel> users;

  JoinQuizEvent({required this.users});
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

class AnswerQuestionEvent extends DoExamEvent {}

class TakeQuestionEvent extends DoExamEvent {
  final QuestionModel question;
  TakeQuestionEvent({required this.question});
}
