part of 'count_down_bloc.dart';

abstract class CountDownEvent {}

class StartCountDownEvent extends CountDownEvent {}

class ResetCountDownEvent extends CountDownEvent {}

class UpdateCountDownEvent extends CountDownEvent {}

class EndCountDownEvent extends CountDownEvent {}
