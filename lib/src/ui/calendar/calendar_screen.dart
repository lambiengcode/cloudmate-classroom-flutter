import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/common/widgets/custom_date_picker.dart';
import 'package:cloudmate/src/ui/home/widgets/attendance_in_post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
              ),
              SizedBox(
                height: 16.sp,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      bool isLast = index == 2;

                      return _buildContent(
                        context,
                        index + 1,
                        isLast,
                        isLast
                            ? null
                            : RoadMapContentModel(
                                id: '',
                                startTime: DateTime.now(),
                                endTime: DateTime.now().add(
                                  Duration(minutes: 10),
                                ),
                                name: 'Điểm danh nhé các bạn!',
                                description: '',
                                type: RoadMapContentType.attendance,
                                roadMapContentId: '',
                              ),
                      );
                    },
                  ),
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
                  AttendanceInPost(roadMapContent: roadMapContentModel)
                ],
              ),
            ),
    );
  }
}
