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
  GettingClasses({required this.listClasses});

  @override
  List get props => [listClasses];
}

class GetClassesDone extends ClassState {
  final List<ClassModel> listClasses;
  GetClassesDone({required this.listClasses});

  @override
  List get props => [listClasses];
}
