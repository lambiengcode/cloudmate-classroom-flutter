import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map/road_map_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map_content/road_map_content_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/bottom_option_road_map.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:cloudmate/src/ui/home/widgets/attendance_in_post.dart';
import 'package:cloudmate/src/ui/home/widgets/deadline_in_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RoadMapContentScreen extends StatefulWidget {
  final RoadMapModel roadMapModel;
  final RoadMapBloc roadMapBloc;
  final ClassModel classModel;
  const RoadMapContentScreen(
      {required this.roadMapModel, required this.roadMapBloc, required this.classModel});
  @override
  State<StatefulWidget> createState() => _RoadMapContentScreenState();
}

class _RoadMapContentScreenState extends State<RoadMapContentScreen> {
  late RoadMapContentBloc _roadMapContentBloc;

  @override
  void initState() {
    _roadMapContentBloc = RoadMapContentBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoadMapContentBloc>(
      create: (context) => _roadMapContentBloc
        ..add(
          GetRoadMapContentEvent(
            classId: widget.classModel.id,
            roadMapId: widget.roadMapModel.id,
          ),
        ),
      child: BlocBuilder<RoadMapContentBloc, RoadMapContentState>(
        builder: (context, state) {
          if (state is RoadMapContentInitial) {
            return LoadingScreen();
          }

          return Scaffold(
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
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return BottomOptionRoadMap(
                          roadMapBloc: widget.roadMapBloc,
                          roadMapModel: widget.roadMapModel,
                          classModel: widget.classModel,
                        );
                      },
                    );
                  },
                  icon: Icon(
                    PhosphorIcons.dotsNine,
                    size: 20.sp,
                    color: colorDarkGrey,
                  ),
                ),
                IconButton(
                  onPressed: () => AppNavigator.push(
                    AppRoutes.CREATE_ROAD_MAP_CONTENT,
                    arguments: {
                      'roadMapContentBloc': _roadMapContentBloc,
                      'classId': widget.classModel.id,
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
                    child: state.props[0].isEmpty
                        ? SizedBox()
                        : Container(
                            child: ListView.builder(
                              itemCount: state.props[0].length,
                              itemBuilder: (context, index) {
                                bool isLast = index == state.props[0].length;

                                return _buildContent(
                                  context,
                                  index + 1,
                                  isLast,
                                  isLast ? null : state.props[0][index],
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, int index, bool isLast, RoadMapContentModel roadMapContentModel) {
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
                      roadMapContentModel.name,
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
                          isAdmin:
                              AppBloc.authBloc.userModel?.id == widget.classModel.createdBy?.id,
                          quantityMembers: widget.classModel.members.length,
                        )
                      : DeadlineInPost(
                          roadMapContent: roadMapContentModel,
                          isAdmin:
                              AppBloc.authBloc.userModel?.id == widget.classModel.createdBy?.id,
                          quantityMembers: widget.classModel.members.length,
                        ),
                ],
              ),
            ),
    );
  }
}
