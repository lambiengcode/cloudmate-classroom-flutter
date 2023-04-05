import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/helpers/role_helper.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/dialog_add_answer.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_confirm.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DrawerOption extends StatefulWidget {
  final ClassModel classModel;
  const DrawerOption({
    required this.classModel,
  });
  @override
  State<StatefulWidget> createState() => _DrawerOptionState();
}

class _DrawerOptionState extends State<DrawerOption> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 100.h,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.sp),
                  ...widget.classModel.createdBy!.id != AppBloc.authBloc.userModel!.id
                      ? []
                      : [
                          _buildLine(
                            context,
                            'Tạo kiểm tra ngay',
                            PhosphorIcons.clockAfternoon,
                            colorAttendance,
                            AppRoutes.LIST_EXAM,
                            arguments: {
                              'isPickedMode': true,
                              'classModel': widget.classModel,
                            },
                          ),
                          _buildDividerTransparant(context),
                          _buildLine(
                            context,
                            'Chỉnh sửa lớp học',
                            PhosphorIcons.pen,
                            colorPrimary,
                            AppRoutes.CREATE_CLASS,
                            arguments: {
                              'classModel': widget.classModel,
                            },
                          ),
                          _buildDividerTransparant(context),
                          _buildLine(
                            context,
                            'Bộ đề kiểm tra',
                            PhosphorIcons.clipboard,
                            colorPrimary,
                            AppRoutes.LIST_EXAM,
                            arguments: {
                              'classModel': widget.classModel,
                            },
                          ),
                          _buildDividerTransparant(context),
                        ],
                  _buildLine(
                    context,
                    'Lịch sử kiểm tra',
                    PhosphorIcons.clockClockwise,
                    null,
                    AppRoutes.HISTORY_EXAM,
                    arguments: {
                      'classId': widget.classModel.id,
                    },
                  ),
                  _buildDividerTransparant(context),
                  _buildLine(
                    context,
                    'Lộ trình',
                    PhosphorIcons.graduationCap,
                    null,
                    AppRoutes.ROAD_MAP,
                    arguments: {
                      'classModel': widget.classModel,
                    },
                  ),
                  _buildDividerTransparant(context),
                  _buildLine(
                    context,
                    'Thành viên',
                    PhosphorIcons.usersFour,
                    null,
                    AppRoutes.LIST_MEMBERS,
                    arguments: {
                      'classModel': widget.classModel,
                    },
                  ),
                  _buildDividerTransparant(context),
                  RoleHelper().canShowOptionReport(
                          widget.classModel.members, widget.classModel.createdBy!.id)
                      ? _buildLine(
                          context,
                          'Báo xấu',
                          PhosphorIcons.info,
                          null,
                          null,
                          handlePressed: () async {
                            await dialogAnimationWrapper(
                              context: context,
                              dismissible: true,
                              slideFrom: 'bottom',
                              child: DialogInput(
                                handleFinish: (input) {
                                  AppNavigator.popUntil(AppRoutes.DETAILS_CLASS);
                                },
                                title: 'Báo xấu lớp học',
                                buttonTitle: 'Đồng ý',
                                hideInputField: 'Nhập lí do...',
                              ),
                            );
                          },
                        )
                      : SizedBox(),
                  RoleHelper().canShowOptionReport(
                          widget.classModel.members, widget.classModel.createdBy!.id)
                      ? _buildDivider(context)
                      : SizedBox(),
                  _buildLine(
                    context,
                    'Rời lớp',
                    PhosphorIcons.signOut,
                    colorHigh,
                    null,
                    handlePressed: () {
                      dialogAnimationWrapper(
                        context: context,
                        slideFrom: 'bottom',
                        child: DialogConfirm(
                          handleConfirm: () {
                            showDialogLoading(context);
                            AppBloc.classBloc.add(
                              LeaveClass(classId: widget.classModel.id, context: context),
                            );
                          },
                          subTitle: 'Sau khi rời khỏi lớp học bạn sẽ không thể hoàn tác lại!',
                          title: 'Rời lớp học',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine(
    context,
    title,
    icon,
    color,
    routeName, {
    Object? arguments,
    Function? handlePressed,
  }) {
    return GestureDetector(
      onTap: () {
        if (routeName != null) {
          AppNavigator.pop();
          AppNavigator.push(routeName, arguments: arguments);
        } else {
          if (handlePressed != null) {
            handlePressed();
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 12.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: color,
            ),
            SizedBox(width: 8.sp),
            Padding(
              padding: EdgeInsets.only(top: 1.25.sp),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color ?? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.75),
                  fontFamily: FontFamily.lato,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerTransparant(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.8),
      child: Divider(
        thickness: .1,
        height: .1,
        indent: 8.sp,
        endIndent: 10.w,
      ),
    );
  }

  Widget _buildDivider(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.8),
      child: Divider(
        thickness: .12,
        height: .12,
        indent: 8.sp,
        endIndent: 10.w,
      ),
    );
  }
}
