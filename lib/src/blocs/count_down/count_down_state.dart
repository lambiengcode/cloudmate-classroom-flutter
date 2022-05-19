part of 'count_down_bloc.dart';

@immutable
abstract class CountDownState {}

class CountDownInitial extends CountDownState {}

class InProgressCountDown extends CountDownState {
  final int duration;
  InProgressCountDown({required this.duration});
}
