part of 'exam_bloc.dart';

@immutable
abstract class ExamEvent {}

class GetListExamEvent extends ExamEvent {
  final String classId;
  GetListExamEvent({required this.classId});
}

class CreateExamEvent extends ExamEvent {
  final BuildContext context;
  final String classId;
  final String name;
  final String description;
  CreateExamEvent({
    required this.context,
    required this.classId,
    required this.name,
    required this.description,
  });
}

class EditExamEvent extends ExamEvent {
  final BuildContext context;
  final String examId;
  final String name;
  final String description;
  EditExamEvent({
    required this.context,
    required this.examId,
    required this.name,
    required this.description,
  });
}

class DeleteExamEvent extends ExamEvent {
  final BuildContext context;
  final String examId;
  DeleteExamEvent({
    required this.context,
    required this.examId,
  });
}
