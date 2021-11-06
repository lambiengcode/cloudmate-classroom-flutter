import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map/road_map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RoadMapContentScreen extends StatefulWidget {
  final RoadMapModel roadMapModel;
  final RoadMapBloc roadMapBloc;
  const RoadMapContentScreen({required this.roadMapModel, required this.roadMapBloc});
  @override
  State<StatefulWidget> createState() => _RoadMapContentScreenState();
}

class _RoadMapContentScreenState extends State<RoadMapContentScreen> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () => AppNavigator.pop(),
            icon: Icon(
              PhosphorIcons.listPlusBold,
              size: 20.sp,
              color: colorPrimary,
            ),
          ),
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
            SizedBox(height: 12.sp),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return _buildContent(context, index == 11);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isLast) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.28,
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
      startChild: isLast
          ? SizedBox()
          : Container(
              child: Column(
                children: [
                  SizedBox(height: 32.sp),
                  Text(
                    '20/11/2021',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                      fontSize: 11.sp,
                      fontFamily: FontFamily.lato,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  Text(
                    '12:00 AM',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.65),
                      fontSize: 10.5.sp,
                      fontFamily: FontFamily.lato,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
      endChild: isLast
          ? SizedBox()
          : _RightChild(
              title: 'Deadline bài tập về nhà 1',
              message: 'Các bạn nộp tại đây, đặt tên MSSV _HoVaTen.zip /rar',
            ),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    required this.title,
    required this.message,
    this.disabled = false,
  });

  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.sp, right: 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 28.sp),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.lato,
              fontSize: 12.25.sp,
              fontWeight: FontWeight.w600,
              color: colorPrimary,
            ),
          ),
          SizedBox(height: 6.sp),
          Text(
            message,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: FontFamily.lato,
              fontSize: 11.75.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.sp),
        ],
      ),
    );
  }
}
