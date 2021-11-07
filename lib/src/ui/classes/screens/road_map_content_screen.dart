import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/resources/hard/hard_attended.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map/road_map_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map_content/road_map_content_bloc.dart';
import 'package:cloudmate/src/ui/home/widgets/attendance_in_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RoadMapContentScreen extends StatefulWidget {
  final RoadMapModel roadMapModel;
  final RoadMapBloc roadMapBloc;
  final String classId;
  const RoadMapContentScreen(
      {required this.roadMapModel, required this.roadMapBloc, required this.classId});
  @override
  State<StatefulWidget> createState() => _RoadMapContentScreenState();
}

class _RoadMapContentScreenState extends State<RoadMapContentScreen> {
  late RoadMapContentBloc _roadMapContentBloc;

  @override
  void initState() {
    super.initState();
    _roadMapContentBloc = RoadMapContentBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _roadMapContentBloc
        ..add(
          GetRoadMapContentEvent(
            classId: widget.classId,
            roadMapId: widget.roadMapModel.id,
          ),
        ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          systemOverlayStyle: ThemeService.systemBrightness,
          centerTitle: true,
          elevation: .0,
          leading: IconButton(
            onPressed: () => AppNavigator.pop(),
            icon: Icon(
              PhosphorIcons.caretLeft,
              size: 20.sp,
            ),
          ),
          title: Text(
            widget.roadMapModel.name,
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: FontFamily.lato,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => AppNavigator.push(
                AppRoutes.CREATE_ROAD_MAP_CONTENT,
                arguments: {
                  'roadMapContentBloc': _roadMapContentBloc,
                  'classId': widget.classId,
                  'roadMapId': widget.roadMapModel.id,
                },
              ),
              icon: Icon(
                PhosphorIcons.listPlusBold,
                size: 20.sp,
                color: colorPrimary,
              ),
            ),
          ],
        ),
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.only(bottom: 12.sp),
          child: Column(
            children: <Widget>[
              SizedBox(height: 2.5.sp),
              Divider(
                height: .25,
                thickness: .25,
              ),
              SizedBox(height: 12.sp),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return _buildContent(context, index + 1, index == 11);
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

  Widget _buildContent(BuildContext context, int index, bool isLast) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.14,
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
        child: Container(
          decoration: isLast ? null : AppDecoration.buttonActionCircleActive(context).decoration,
          padding: EdgeInsets.all(6.sp),
          child: Text(
            isLast ? '' : index.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.lato,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: colorPrimary,
            ),
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
                      'Các em điểm danh tại đây nha...',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  ),
                  AttendanceInPost(
                    roadMapContent: RoadMapContentModel(
                      id: '',
                      startTime: DateTime.now(),
                      endTime: DateTime.now().add(
                        Duration(minutes: 10),
                      ),
                      type: RoadMapContentType.assignment,
                      name: '',
                      description: '',
                      roadMapContentId: ''
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
