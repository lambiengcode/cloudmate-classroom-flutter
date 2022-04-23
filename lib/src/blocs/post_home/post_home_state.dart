part of 'post_home_bloc.dart';

@immutable
abstract class PostHomeState {
  List get props => [];
}

class PostHomeInitial extends PostHomeState {
  @override
  List get props => [[]];
}

class GettingPostHome extends PostHomeState {
  final List<PostModel> posts;
  GettingPostHome({required this.posts});

  @override
  List get props => [posts];
}

class GetDonePostHome extends PostHomeState {
  final List<PostModel> posts;
  GetDonePostHome({required this.posts});

  @override
  List get props => [posts];
}
