import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/ui/classes/screens/submit_deadline_screen.dart';
import 'package:cloudmate/src/ui/home/widgets/bottom_sheet_assignment.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DeadlineInPost extends StatefulWidget {
  final RoadMapContentModel roadMapContent;
  final bool isAdmin;
  final int quantityMembers;
  const DeadlineInPost({
    required this.roadMapContent,
    required this.isAdmin,
    required this.quantityMembers,
  });
  @override
  State<StatefulWidget> createState() => _ExamInPostCard();
}

class _ExamInPostCard extends State<DeadlineInPost> {
  _handlePressedOpenSubmit() {
    if (widget.isAdmin) {
      // Admin in class
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.sp),
          ),
        ),
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => BottomSheetAssignment(
          roadMapContentModel: widget.roadMapContent,
        ),
      );
    } else {
      // Member in class
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.sp),
          ),
        ),
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SubmitDeadlineScreen(
          roadMapContentModel: widget.roadMapContent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('assignments')
          // .where('createdBy', isEqualTo: AppBloc.authBloc.userModel?.id)
          .where('roadMapContentId', isEqualTo: widget.roadMapContent.id)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List assignments = snapshot.data?.docs ?? [];

        int myAssignmentIndex =
            assignments.indexWhere((item) => item['createdBy'] == AppBloc.authBloc.userModel?.id);

        return GestureDetector(
          onTap: () => _handlePressedOpenSubmit(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
            padding: EdgeInsets.all(12.5.sp),
            decoration: AppDecoration.buttonActionBorderActive(context, 10.sp).decoration,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.roadMapContent.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: colorHigh,
                          fontFamily: FontFamily.lato,
                        ),
                      ),
                      SizedBox(height: 6.sp),
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.clock,
                            size: 15.sp,
                          ),
                          SizedBox(width: 6.sp),
                          Text(
                            DateFormat('HH:mm - dd/MM/yyyy').format(
                              widget.roadMapContent.endTime,
                            ),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: FontFamily.lato,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.sp),
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.folderNotchOpen,
                            size: 15.sp,
                          ),
                          SizedBox(width: 6.sp),
                          Expanded(
                            child: Text(
                              widget.isAdmin
                                  ? '${assignments.length}/${widget.quantityMembers}'
                                  : (myAssignmentIndex != -1
                                      ? assignments[myAssignmentIndex]['fileName']
                                      : 'Chưa nộp'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handlePressedOpenSubmit();
                  },
                  child: Container(
                    height: 32.sp,
                    width: 32.sp,
                    decoration: BoxDecoration(
                      color: colorHigh,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIcons.folderNotchOpenFill,
                      size: 15.sp,
                      color: mC,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
