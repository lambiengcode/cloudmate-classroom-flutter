import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/models/assignment_firestore_model.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/home/widgets/user_assignment_done.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomSheetAssignment extends StatefulWidget {
  final RoadMapContentModel roadMapContentModel;
  const BottomSheetAssignment({required this.roadMapContentModel});
  @override
  State<StatefulWidget> createState() => _BottomSheetAssignmentState();
}

class _BottomSheetAssignmentState extends State<BottomSheetAssignment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 8.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    AppNavigator.pop();
                  },
                  icon: Icon(
                    PhosphorIcons.x,
                    color: colorPrimary,
                    size: 20.sp,
                  ),
                ),
                Text('Danh sách nộp bài'),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    null,
                    color: colorPrimary,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('assignments')
                  .where('roadMapContentId', isEqualTo: widget.roadMapContentModel.id)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                List<AssignmentFirestoreModel> assignments = ((snapshot.data?.docs ?? []))
                    .map((e) => AssignmentFirestoreModel.fromMap(e))
                    .toList();

                return ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    return UserAssignmentDone(
                      assignment: assignments[index],
                      isLast: index == assignments.length - 1,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
