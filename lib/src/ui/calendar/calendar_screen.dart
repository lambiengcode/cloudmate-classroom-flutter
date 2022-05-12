import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/schedules/schedules_bloc.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/common/widgets/custom_date_picker.dart';
import 'package:cloudmate/src/ui/home/widgets/attendance_in_post.dart';
import 'package:cloudmate/src/ui/home/widgets/deadline_in_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    AppBloc.schedulesBloc.add(CleanScheduleEvent());
    AppBloc.schedulesBloc.add(GetScheduleEvent(currentDate: _currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 4.sp),
          child: Column(
            children: [
              CustomDayPicker(
                handlePickerSelected: null,
                isTheOtherPickerSelected: null,
                onChanged: (date) {
                  _currentDate = date;

                  AppBloc.schedulesBloc.add(GetScheduleEvent(currentDate: _currentDate));
                },
              ),
              SizedBox(
                height: 16.sp,
              ),
              Expanded(
                child: BlocBuilder<SchedulesBloc, SchedulesState>(
                  builder: (context, state) {
                    if (state is GetScheduleDone) {
                      return Container(
                        child: ListView.builder(
                          itemCount: state.roadmapContent.length,
                          itemBuilder: (context, index) {
                            bool isLast = index == state.roadmapContent.length;

                            return _buildContent(
                              context,
                              index + 1,
                              isLast,
                              isLast ? null : state.roadmapContent[index],
                            );
                          },
                        ),
                      );
                    }

                    return Container(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, int index, bool isLast, RoadMapContentModel? roadMapContentModel) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      beforeLineStyle: LineStyle(
        color: colorPrimary,
      ),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.0,
        drawGap: true,
        width: 16.sp,
        height: 16.sp,
        color: colorPrimary,
      ),
      isLast: isLast,
      startChild: Container(
        padding: EdgeInsets.only(left: 4.sp, top: 12.sp),
        child: Text(
          isLast ? '' : DateFormat('HH:mm a').format(roadMapContentModel!.endTime),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: FontFamily.lato,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: colorPrimary,
          ),
        ),
      ),
      endChild: isLast
          ? SizedBox()
          : Container(
              padding: EdgeInsets.only(top: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3.w, bottom: 4.sp),
                    child: Text(
                      roadMapContentModel!.name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  ),
                  roadMapContentModel.type == RoadMapContentType.attendance
                      ? AttendanceInPost(
                          roadMapContent: roadMapContentModel,
                          isAdmin: false,
                          quantityMembers: 0,
                        )
                      : DeadlineInPost(
                          roadMapContent: roadMapContentModel,
                          isAdmin: false,
                          quantityMembers: 0,
                        ),
                ],
              ),
            ),
    );
  }
}
