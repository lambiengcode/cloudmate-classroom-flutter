part of 'road_map_content_bloc.dart';

@immutable
abstract class RoadMapContentEvent {}

class CreateRoadMapContentEvent extends RoadMapContentEvent {
  final String classId;
  final String roadMapId;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final BuildContext context;
  final RoadMapContentType type;
  final List<String>? fileExtensions;
  CreateRoadMapContentEvent({
    required this.classId,
    required this.roadMapId,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.context,
    required this.type,
    required this.fileExtensions,
  });
}

class GetRoadMapContentEvent extends RoadMapContentEvent {
  final String classId;
  final String roadMapId;
  GetRoadMapContentEvent({required this.classId, required this.roadMapId});
}
