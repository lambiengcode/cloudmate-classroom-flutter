import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final QueryDocumentSnapshot snapshot;
  const CommentCard({required this.snapshot});
  @override
  State<StatefulWidget> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .where('_id', isEqualTo: widget.snapshot['userId'])
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (mounted) {
          setState(() {
            userModel = UserModel.fromMap(value.docs.first);
          });
        } else {
          userModel = UserModel.fromMap(value.docs.first);
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant CommentCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    FirebaseFirestore.instance
        .collection('users')
        .where('_id', isEqualTo: widget.snapshot['userId'])
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (mounted) {
          setState(() {
            userModel = UserModel.fromMap(value.docs.first);
          });
        } else {
          userModel = UserModel.fromMap(value.docs.first);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.sp,
        right: 4.sp,
        bottom: 16.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 26.sp,
                  width: 26.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        userModel?.image ?? Constants.urlImageDefault,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: userModel?.displayName ?? 'User',
                              style: TextStyle(
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            TextSpan(
                              text: '\t${widget.snapshot['content']}',
                              style: TextStyle(
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.85.sp,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('HH:mm - dd/MM/yyyy')
                                .format((widget.snapshot['createdBy'] as Timestamp).toDate()),
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.75),
                              fontFamily: FontFamily.lato,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.sp),
          // IconButton(
          //   onPressed: () => null,
          //   icon: Icon(
          //     PhosphorIcons.heart,
          //     color: null,
          //     size: 16.sp,
          //   ),
          // ),
        ],
      ),
    );
  }
}
