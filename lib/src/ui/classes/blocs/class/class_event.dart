part of 'class_bloc.dart';

@immutable
abstract class ClassEvent {}

class TransitionToClassScreen extends ClassEvent {}

class GetClasses extends ClassEvent {}

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
