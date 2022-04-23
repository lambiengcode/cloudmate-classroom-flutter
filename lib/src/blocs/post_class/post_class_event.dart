part of 'post_class_bloc.dart';

@immutable
abstract class PostClassEvent {}

class GetPostClassEvent extends PostClassEvent {
  final String classId;
  GetPostClassEvent({required this.classId});
}

class CleanPostClassEvent extends PostClassEvent {}
