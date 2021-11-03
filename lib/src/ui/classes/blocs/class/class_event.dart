part of 'class_bloc.dart';

@immutable
abstract class ClassEvent {}

class TransitionToClassScreen extends ClassEvent {}

class GetClasses extends ClassEvent {}

class GetRecommendClasses extends ClassEvent {}

class CreateClass extends ClassEvent {
  final BuildContext context;
  final String name;
  final String topic;
  final String intro;
  CreateClass({
    required this.context,
    required this.name,
    required this.intro,
    required this.topic,
  });
}

class EditClass extends ClassEvent {
  final BuildContext context;
  final String id;
  final String name;
  final String topic;
  final String intro;
  EditClass({
    required this.context,
    required this.id,
    required this.name,
    required this.intro,
    required this.topic,
  });
}

class GetMemberClass extends ClassEvent {
  final String classId;
  GetMemberClass({required this.classId});
}

class JoinClass extends ClassEvent {
  final BuildContext context;
  final String classId;
  JoinClass({required this.classId, required this.context});
}

class LeaveClass extends ClassEvent {
  final BuildContext context;
  final String classId;
  LeaveClass({required this.classId, required this.context});
}

class UpdateImageClass extends ClassEvent {
  final File image;
  final String id;
  UpdateImageClass({required this.image, required this.id});
}
