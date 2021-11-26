part of 'history_quiz_bloc.dart';

@immutable
abstract class HistoryQuizEvent {}

class GetHistoryQuizEvent extends HistoryQuizEvent {
  final String classId;
  GetHistoryQuizEvent({required this.classId});
}
