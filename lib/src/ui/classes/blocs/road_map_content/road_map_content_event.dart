part of 'road_map_content_bloc.dart';

@immutable
abstract class RoadMapContentEvent {}

class CreateRoadMapContentEvent extends RoadMapContentEvent {
  final String classId;
  final String roadMapId;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final BuildContext context;
  CreateRoadMapContentEvent({
    required this.classId,
    required this.roadMapId,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.context,
  });
}

class GetRoadMapContentEvent extends RoadMapContentEvent {
  final String classId;
  final String roadMapId;
  GetRoadMapContentEvent({required this.classId, required this.roadMapId});
}
