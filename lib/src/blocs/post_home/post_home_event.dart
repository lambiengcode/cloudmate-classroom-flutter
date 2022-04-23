part of 'post_home_bloc.dart';

@immutable
abstract class PostHomeEvent {}

class OnPostHomeEvent extends PostHomeEvent {}

class GetPostHomeEvent extends PostHomeEvent {}

class CleanPostHomeEvent extends PostHomeEvent {}
