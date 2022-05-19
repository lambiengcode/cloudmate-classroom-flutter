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
  final double price;
  CreateClass({
    required this.context,
    required this.name,
    required this.intro,
    required this.topic,
    required this.price,
  });
}

class EditClass extends ClassEvent {
  final BuildContext context;
  final String id;
  final String name;
  final String topic;
  final String intro;
  final double price;
  final List<String> setOfQuestionShare;

  EditClass({
    required this.context,
    required this.id,
    required this.name,
    required this.intro,
    required this.topic,
    required this.setOfQuestionShare,
    required this.price,
  });
}

class GetMemberClass extends ClassEvent {
  final String classId;
  GetMemberClass({required this.classId});
}

class JoinClass extends ClassEvent {
  final BuildContext context;
  final String classId;
  final double amount;
  final String senderPhone;
  JoinClass({
    required this.classId,
    required this.context,
    required this.senderPhone,
    required this.amount,
  });
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

class ClearClass extends ClassEvent {}
