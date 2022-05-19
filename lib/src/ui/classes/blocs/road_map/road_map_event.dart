part of 'road_map_bloc.dart';

@immutable
abstract class RoadMapEvent {}

class GetRoadMapEvent extends RoadMapEvent {
  final String classId;
  GetRoadMapEvent({required this.classId});
}

class CreateRoadMapEvent extends RoadMapEvent {
  final BuildContext context;
  final String classId;
  final String name;
  final String description;
  CreateRoadMapEvent({
    required this.context,
    required this.classId,
    required this.name,
    required this.description,
  });
}

class UpdateRoadMapEvent extends RoadMapEvent {
  final String id;
  final String name;
  final String description;
  final BuildContext context;
  UpdateRoadMapEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.context,
  });
}

class DeleteRoadMapEvent extends RoadMapEvent {
  final String id;
  DeleteRoadMapEvent({required this.id});
}
