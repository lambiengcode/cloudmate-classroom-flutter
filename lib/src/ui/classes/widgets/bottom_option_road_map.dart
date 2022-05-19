import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map/road_map_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_confirm.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class BottomOptionRoadMap extends StatefulWidget {
  final RoadMapModel roadMapModel;
  final RoadMapBloc roadMapBloc;
  final ClassModel classModel;
  BottomOptionRoadMap({
    required this.roadMapModel,
    required this.roadMapBloc,
    required this.classModel,
  });
  @override
  State<StatefulWidget> createState() => _BottomOptionRoadMapState();
}

class _BottomOptionRoadMapState extends State<BottomOptionRoadMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.sp),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: 35.w),
              decoration: AppDecoration.buttonActionBorder(context, 30.sp).decoration,
            ),
            SizedBox(height: 8.0),
            // _buildAction(context, 'Chỉnh sửa lộ trình', PhosphorIcons.pencil),
            // Divider(
            //   color: Colors.grey,
            //   thickness: .25,
            //   height: .25,
            //   indent: 8.0,
            //   endIndent: 8.0,
            // ),
            _buildAction(context, 'Chỉnh sửa lộ trình', PhosphorIcons.pencil),
            SizedBox(height: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Chỉnh sửa lộ trình':
            AppNavigator.pop();
            AppNavigator.push(AppRoutes.CREATE_ROAD_MAP, arguments: {
              'classModel': widget.classModel,
              'roadMapBloc': widget.roadMapBloc,
              'roadMapModel': widget.roadMapModel,
            });
            break;
          case 'Xoá lộ trình':
            dialogAnimationWrapper(
              context: context,
              slideFrom: 'left',
              child: DialogConfirm(
                handleConfirm: () {
                  showDialogLoading(context);
                  widget.roadMapBloc.add(DeleteRoadMapEvent(id: widget.roadMapModel.id));
                },
                subTitle: 'Sau khi xoá lộ trình bạn sẽ không thể khôi phục lại dữ liệu này',
                title: 'Xoá lộ trình',
              ),
            );
            break;
          default:
            break;
        }
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade800
                      : Colors.white,
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade800
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
