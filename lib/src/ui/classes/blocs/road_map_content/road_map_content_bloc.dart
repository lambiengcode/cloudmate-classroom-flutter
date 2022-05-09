import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/post_class/post_class_bloc.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/resources/remote/road_map_content_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_notice.dart';
import 'package:flutter/material.dart';
part 'road_map_content_event.dart';
part 'road_map_content_state.dart';

class RoadMapContentBloc extends Bloc<RoadMapContentEvent, RoadMapContentState> {
  RoadMapContentBloc() : super(RoadMapContentInitial());

  List<RoadMapContentModel> roadMapContentList = [];
  bool isRoadMapContentOver = false;

  @override
  Stream<RoadMapContentState> mapEventToState(RoadMapContentEvent event) async* {
    if (event is GetRoadMapContentEvent) {
      if (roadMapContentList.length == 0) {
        yield RoadMapContentInitial();
      } else {
        yield GettingRoadMapContent(roadMapContentList: roadMapContentList);
      }

      await _getRoadMapContentList(classId: event.classId, roadMapId: event.roadMapId);
      yield GetDoneRoadMapContent(roadMapContentList: roadMapContentList);
    }

    if (event is CreateRoadMapContentEvent) {
      bool isCreateSuccess = await _createRoadMapContent(event);

      yield GetDoneRoadMapContent(roadMapContentList: roadMapContentList);

      if (isCreateSuccess) {
        AppBloc.postClassBloc.add(GetPostClassEvent(classId: event.classId));
        AppNavigator.popUntil(AppRoutes.ROAD_MAP_CONTENT);
      } else {
        _showDialogResult(event.context);
      }
    }
  }

  // MARK: - Private Methods

  Future<bool> _createRoadMapContent(CreateRoadMapContentEvent event) async {
    RoadMapContentModel? roadMapContentModel =
        await RoadMapContentRepository().createRoadMapContent(
      isCreateAssignment: event.type == RoadMapContentType.assignment,
      classId: event.classId,
      roadMapId: event.roadMapId,
      name: event.name,
      startTime: event.startTime.toUtc().toString().split(' ').join('T'),
      endTime: event.endTime.toUtc().toString().split(' ').join('T'),
      fileExtensions: event.fileExtensions,
    );

    AppNavigator.pop();

    if (roadMapContentModel != null) {
      roadMapContentList.add(roadMapContentModel);
    }

    return roadMapContentModel != null;
  }

  Future<void> _getRoadMapContentList({required String classId, required String roadMapId}) async {
    List<RoadMapContentModel> roadMapContents =
        await RoadMapContentRepository().getListRoadMapContent(
      classId: classId,
      roadMapId: roadMapId,
    );

    if (roadMapContents.isEmpty) {
      isRoadMapContentOver = true;
    } else {
      roadMapContentList.addAll(roadMapContents);
    }
  }

  void _showDialogResult(
    context, {
    String title = 'Thất bại',
    String subTitle = 'Tạo thất bại, hãy thử lại sau!',
  }) {
    dialogAnimationWrapper(
      dismissible: false,
      context: context,
      child: DialogNotice(
        title: title,
        subTitle: subTitle,
      ),
    );
  }
}
