part of 'post_home_bloc.dart';

@immutable
abstract class PostHomeEvent {}

class OnPostHomeEvent extends PostHomeEvent {}

class GetPostHomeEvent extends PostHomeEvent {}

class CreatePostHomeEvent extends PostHomeEvent {
  final List<String> classChooses;
  final String content;
  CreatePostHomeEvent({required this.classChooses, required this.content});
}

class CleanPostHomeEvent extends PostHomeEvent {}
