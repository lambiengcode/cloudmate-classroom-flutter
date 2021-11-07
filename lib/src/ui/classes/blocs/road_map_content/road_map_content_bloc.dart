import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/resources/remote/road_map_content_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'road_map_content_event.dart';
part 'road_map_content_state.dart';

class RoadMapContentBloc extends Bloc<RoadMapContentEvent, RoadMapContentState> {
  RoadMapContentBloc() : super(RoadMapContentInitial());

  List<RoadMapContentModel> roadMapContentList = [];
  bool isRoadMapContentOver = false;

  @override
  Stream<RoadMapContentState> mapEventToState(RoadMapContentEvent event) async* {
    
  }

  // MARK: - Private Methods

  Future<bool> _createRoadMapContent({
    required String classId,
    required String roadMapId,
    required String name,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    RoadMapContentModel? roadMapContentModel =
        await RoadMapContentRepository().createRoadMapContent(
      classId: classId,
      roadMapId: roadMapId,
      name: name,
      description: description,
      startTime: startTime.toUtc().toString().split(' ').join('T'),
      endTime: endTime.toUtc().toString().split(' ').join('T'),
    );

    AppNavigator.pop();

    if (roadMapContentModel != null) {
      roadMapContentList.add(roadMapContentModel);
    }

    return roadMapContentModel != null;
  }

  Future<void> _getRoadMapContentList({required String classId, required String roadMapId}) async {
    List<RoadMapContentModel> roadMapContents = await RoadMapContentRepository().getListRoadMapContent(
      classId: classId,
      roadMapId: roadMapId,
    );

    if (roadMapContents.isEmpty) {
      isRoadMapContentOver = true;
    }else {
      roadMapContentList.addAll(roadMapContents);
    }
  }
}
