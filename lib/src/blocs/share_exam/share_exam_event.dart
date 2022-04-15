part of 'share_exam_bloc.dart';

@immutable
abstract class ShareExamEvent {}

class GetShareExamEvent extends ShareExamEvent {}

class CreateShareExamEvent extends ShareExamEvent {
  final BuildContext context;
  final String name;
  final String description;
  CreateShareExamEvent({
    required this.context,
    required this.name,
    required this.description,
  });
}
