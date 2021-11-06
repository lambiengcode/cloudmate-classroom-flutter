part of 'road_map_bloc.dart';

@immutable
abstract class RoadMapState {
  List<dynamic> get props => [];
}

class RoadMapInitial extends RoadMapState {}

class GettingRoadMap extends RoadMapState {
  final List<RoadMapModel> roadMaps;

  GettingRoadMap({required this.roadMaps});

  @override
  List get props => [roadMaps];
}

class GetDoneRoadMap extends RoadMapState {
  final List<RoadMapModel> roadMaps;

  GetDoneRoadMap({required this.roadMaps});

  @override
  List get props => [roadMaps];
}
