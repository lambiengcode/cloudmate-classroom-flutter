part of 'road_map_content_bloc.dart';

@immutable
abstract class RoadMapContentState {
  List<dynamic> get props => [];
}

class RoadMapContentInitial extends RoadMapContentState {}

class GettingRoadMapContent extends RoadMapContentState {
  final List<RoadMapContentModel> roadMapContentList;

  GettingRoadMapContent({required this.roadMapContentList});

  @override
  List get props => [roadMapContentList];
}

class GetDoneRoadMapContent extends RoadMapContentState {
  final List<RoadMapContentModel> roadMapContentList;

  GetDoneRoadMapContent({required this.roadMapContentList});

  @override
  List get props => [roadMapContentList];
}
