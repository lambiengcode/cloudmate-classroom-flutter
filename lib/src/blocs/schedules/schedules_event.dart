part of 'schedules_bloc.dart';

@immutable
abstract class SchedulesEvent {}

class GetScheduleEvent extends SchedulesEvent {
  final DateTime currentDate;
  GetScheduleEvent({required this.currentDate});
}

class CleanScheduleEvent extends SchedulesEvent {}
