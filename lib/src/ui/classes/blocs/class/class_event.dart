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
