part of 'road_map_bloc.dart';

@immutable
abstract class RoadMapState {}

class RoadMapInitial extends RoadMapState {}

class GettingRoadMap extends RoadMapState {}

class GetDoneRoadMap extends RoadMapState {
  final List<RoadMapModel> roadMaps;

  GetDoneRoadMap({required this.roadMaps});
}
