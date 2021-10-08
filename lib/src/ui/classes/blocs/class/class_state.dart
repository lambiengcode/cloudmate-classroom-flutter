part of 'class_bloc.dart';

@immutable
abstract class ClassState {
  List<dynamic> get props => [];
}

class ClassInitial extends ClassState {
  @override
  List get props => [[]];
}

class GettingClasses extends ClassState {
  final List<ClassModel> listClasses;
  final List<ClassModel> listRecommend;
  final bool isOver;
  GettingClasses({
    required this.listClasses,
    required this.listRecommend,
    this.isOver = false,
  });

  @override
  List get props => [listClasses, listRecommend];
}

class GetClassesDone extends ClassState {
  final List<ClassModel> listClasses;
  final List<ClassModel> listRecommend;
  final bool isOver;
  GetClassesDone({
    required this.listClasses,
    required this.listRecommend,
    this.isOver = false,
  });

  @override
  List get props => [listClasses, listRecommend];
}
