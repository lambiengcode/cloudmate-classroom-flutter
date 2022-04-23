part of 'post_class_bloc.dart';

@immutable
abstract class PostClassState {
  List get props => [];
}

class PostClassInitial extends PostClassState {
  @override
  List get props => [[]];
}

class GettingPostClass extends PostClassState {
  final List<PostModel> posts;
  GettingPostClass({required this.posts});

  @override
  List get props => [posts];
}

class GetDonePostClass extends PostClassState {
  final List<PostModel> posts;
  GetDonePostClass({required this.posts});

  @override
  List get props => [posts];
}
