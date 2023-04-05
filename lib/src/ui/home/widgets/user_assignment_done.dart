import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/helpers/export_excel.dart';
import 'package:cloudmate/src/models/assignment_firestore_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class UserAssignmentDone extends StatefulWidget {
  final AssignmentFirestoreModel assignment;
  final bool isLast;
  UserAssignmentDone({
    required this.assignment,
    this.isLast = false,
  });
  @override
  State<StatefulWidget> createState() => _UserAssignmentDoneState();
}

class _UserAssignmentDoneState extends State<UserAssignmentDone> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('_id', isEqualTo: widget.assignment.createdBy)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List datas = snapshot.data?.docs ?? [];

        UserModel? userModel;

        if (datas.isNotEmpty) {
          userModel = UserModel.fromMap(datas.first);
        }

        return Container(
          padding: EdgeInsets.only(left: 12.sp, right: 8.sp),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 42.5.sp,
                            width: 42.5.sp,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(250.sp),
                              child: BlurHash(
                                hash: userModel?.blurHash ?? '',
                                image: userModel?.image ?? Constants.urlImageDefault,
                                imageFit: BoxFit.cover,
                                curve: Curves.bounceInOut,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userModel?.displayName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.lato,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(.88),
                                  ),
                                ),
                                SizedBox(height: 2.sp),
                                Text(
                                  'File: ${widget.assignment.fileName}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: FontFamily.lato,
                                      ),
                                ),
                                SizedBox(height: 2.sp),
                                Text(
                                  DateFormat('HH:mm - dd/MM/yyyy')
                                      .format(widget.assignment.createdAt.toDate()),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: FontFamily.lato,
                                        color: colorPrimary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialogLoading(context);
                        await saveFile(
                          urlToFile: widget.assignment.urlToFile,
                          fileName: widget.assignment.fileName,
                        );
                      },
                      child: Container(
                        height: 32.sp,
                        width: 32.sp,
                        margin: EdgeInsets.only(right: 2.sp),
                        decoration:
                            AppDecoration.buttonActionBorderActive(context, 6.sp).decoration,
                        child: Icon(
                          PhosphorIcons.download,
                          size: 20.sp,
                          color: colorMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.isLast
                  ? Container()
                  : Divider(
                      thickness: .2,
                      height: .2,
                      indent: 14.w,
                      endIndent: 12.0,
                    ),
            ],
          ),
        );
      },
    );
  }
}
