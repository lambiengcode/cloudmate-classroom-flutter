import 'dart:math';

import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map/road_map_bloc.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class RoadMapScreen extends StatefulWidget {
  final ClassModel classModel;
  const RoadMapScreen({required this.classModel});
  @override
  _RoadMapScreenState createState() => _RoadMapScreenState();
}

class _RoadMapScreenState extends State<RoadMapScreen> {
  late RoadMapBloc _roadMapBloc;

  @override
  void initState() {
    super.initState();
    _roadMapBloc = RoadMapBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _roadMapBloc
        ..add(
          GetRoadMapEvent(classId: widget.classModel.id),
        ),
      child: BlocBuilder<RoadMapBloc, RoadMapState>(
        builder: (context, state) {
          if (state is RoadMapInitial) {
            return LoadingScreen();
          }

          List<Step> _steps = (state.props[0] as List<RoadMapModel>).asMap().entries.map((e) {
            return Step(
              title: e.value.name,
              message: e.value.description,
              step: e.key + 1,
            );
          }).toList();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
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
                widget.classModel.name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontFamily.lato,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              actions: [
                widget.classModel.createdBy!.id == AppBloc.authBloc.userModel!.id
                    ? IconButton(
                        onPressed: () => AppNavigator.push(AppRoutes.CREATE_ROAD_MAP, arguments: {
                          'classModel': widget.classModel,
                          'roadMapBloc': _roadMapBloc,
                        }),
                        icon: Icon(
                          PhosphorIcons.circlesThreePlus,
                          size: 22.sp,
                          color: colorPrimary,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            body: Container(
              padding: EdgeInsets.only(bottom: 12.sp),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  SizedBox(height: 4.0.sp),
                  Expanded(
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        _TimelineSteps(
                          steps: _steps,
                          roadMaps: state.props[0] as List<RoadMapModel>,
                          roadMapBloc: _roadMapBloc,
                          classModel: widget.classModel,
                        )
                      ],
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
}

class _TimelineSteps extends StatelessWidget {
  const _TimelineSteps({
    required this.steps,
    required this.roadMaps,
    required this.roadMapBloc,
    required this.classModel,
  });

  final List<Step> steps;
  final List<RoadMapModel> roadMaps;
  final RoadMapBloc roadMapBloc;
  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd)
            return TimelineDivider(
              color: colorPrimary,
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );

          final int itemIndex = index ~/ 2;
          final Step step = steps[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            title: step.title!,
            subtitle: step.message!,
            isLeftAlign: isLeftAlign,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == steps.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return GestureDetector(
            onTap: () {
              AppNavigator.push(AppRoutes.ROAD_MAP_CONTENT, arguments: {
                'roadMapModel': roadMaps[itemIndex],
                'roadMapBloc': roadMapBloc,
                'classModel': classModel,
              });
            },
            child: Container(
              color: Colors.transparent,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                endChild: isLeftAlign ? child : null,
                startChild: isLeftAlign ? null : child,
                lineXY: isLeftAlign ? 0.1 : 0.9,
                isFirst: isFirst,
                isLast: isLast,
                indicatorStyle: IndicatorStyle(
                  width: 40,
                  height: 40,
                  indicatorXY: indicatorY,
                  indicator: _TimelineStepIndicator(step: '${step.step}'),
                ),
                beforeLineStyle: LineStyle(
                  color: colorPrimary,
                  thickness: 5,
                ),
              ),
            ),
          );
        },
        childCount: max(0, steps.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  const _TimelineStepIndicator({required this.step});

  final String step;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorPrimary,
      ),
      child: Center(
        child: Text(
          step,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TimelineStepsChild extends StatelessWidget {
  const _TimelineStepsChild({
    required this.title,
    required this.subtitle,
    required this.isLeftAlign,
  });

  final String title;
  final String subtitle;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign
          ? EdgeInsets.only(
              right: 30.sp,
              top: 12.sp,
              bottom: 12.sp,
              left: 6.sp,
            )
          : EdgeInsets.only(
              left: 30.sp,
              top: 12.sp,
              bottom: 12.sp,
              right: 6.sp,
            ),
      child: Column(
        crossAxisAlignment: isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 12.75.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.sp),
          Text(
            subtitle,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 11.25.sp,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}

class Step {
  const Step({
    this.step,
    this.title,
    this.message,
    this.id,
  });

  final String? id;
  final int? step;
  final String? title;
  final String? message;

  factory Step.fromRoadMap(RoadMapModel roadMapModel, int step) {
    return Step(
      step: step,
      title: roadMapModel.name,
      message: roadMapModel.description,
      id: roadMapModel.id,
    );
  }
}
