part of 'schedules_bloc.dart';

@immutable
abstract class SchedulesState {}

class SchedulesInitial extends SchedulesState {}

class GetScheduleDone extends SchedulesState {
  final List<RoadMapContentModel> roadmapContent;
  GetScheduleDone({required this.roadmapContent});
}
