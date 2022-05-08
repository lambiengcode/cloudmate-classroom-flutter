import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/resources/remote/road_map_content_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(SchedulesInitial());

  Map<String, List<RoadMapContentModel>> roadmapContentMap = {};

  @override
  Stream<SchedulesState> mapEventToState(SchedulesEvent event) async* {
    if (event is GetScheduleEvent) {
      String date = DateFormat('MM/yyyy').format(event.currentDate);

      if (roadmapContentMap[date] == null || roadmapContentMap[date]!.isEmpty) {
        List<RoadMapContentModel> _roadmapContent = await RoadMapContentRepository().getSchedules(
          month: event.currentDate.month.toString(),
          year: event.currentDate.year.toString(),
        );

        roadmapContentMap[date] = _roadmapContent;
      }

      yield GetScheduleDone(roadmapContent: roadmapContentMap[date] ?? []);
    }

    if (event is CleanScheduleEvent) {
      roadmapContentMap = {};
      yield SchedulesInitial();
    }
  }
}
