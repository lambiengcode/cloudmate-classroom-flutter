import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/resources/remote/road_map_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_notice.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'road_map_event.dart';
part 'road_map_state.dart';

class RoadMapBloc extends Bloc<RoadMapEvent, RoadMapState> {
  RoadMapBloc() : super(RoadMapInitial());

  List<RoadMapModel> roadMaps = [];

  @override
  Stream<RoadMapState> mapEventToState(RoadMapEvent event) async* {
    if (event is CreateRoadMapEvent) {
      bool isCreateSuccess = await _createRoadMap(
        classId: event.classId,
        name: event.name,
        description: event.description,
      );

      yield GetDoneRoadMap(roadMaps: roadMaps);

      if (isCreateSuccess) {
        _showDialogResult(event.context);
        AppNavigator.popUntil(AppRoutes.DETAILS_CLASS);
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Thêm lộ trình thất bại, thử lại sau!',
        );
      }
    }
  }

  // MARK: - Event handler function
  Future<bool> _createRoadMap({
    required String classId,
    required String name,
    required String description,
  }) async {
    RoadMapModel? roadMapModel = await RoadMapRepository().createRoadMap(
      classId: classId,
      name: name,
      description: description,
    );

    AppNavigator.pop();

    if (roadMapModel != null) {
      roadMaps.add(roadMapModel);
    }
    return roadMapModel != null;
  }

  void _showDialogResult(
    context, {
    String title = 'Thành công',
    String subTitle = 'Bạn đã thêm 1 lộ trình mới thành công',
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
