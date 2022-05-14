import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/helpers/date_time_helper.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/resources/remote/road_map_content_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(SchedulesInitial());

  Map<String, List<RoadMapContentModel>> roadmapContentMap = {};
  DateTime _currentDate = DateTime.now();

  @override
  Stream<SchedulesState> mapEventToState(SchedulesEvent event) async* {
    if (event is GetScheduleEvent) {
      _currentDate = event.currentDate;
      String date = DateFormat('MM/yyyy').format(event.currentDate);

      if (roadmapContentMap[date] == null || roadmapContentMap[date]!.isEmpty) {
        List<RoadMapContentModel> _roadmapContent = await RoadMapContentRepository().getSchedules(
          month: event.currentDate.month.toString(),
          year: event.currentDate.year.toString(),
        );

        roadmapContentMap[date] = _roadmapContent;
      }

      yield GetScheduleDone(roadmapContent: getByDate());
    }

    if (event is CleanScheduleEvent) {
      roadmapContentMap = {};
      yield SchedulesInitial();
    }
  }

  List<RoadMapContentModel> getByDate() {
    List<RoadMapContentModel> roadMapContents =
        roadmapContentMap[DateFormat('MM/yyyy').format(_currentDate)] ?? [];

    return roadMapContents
        .where((request) => isEqualTwoDate(_currentDate, request.endTime))
        .toList();
  }

  int quantityPerDate(DateTime date) {
    List<RoadMapContentModel> roadMapContents =
        roadmapContentMap[DateFormat('MM/yyyy').format(date)] ?? [];
    int quantity =
        roadMapContents.where((request) => isEqualTwoDate(date, request.endTime)).toList().length;
    return quantity >= 3 ? 3 : quantity;
  }
}
