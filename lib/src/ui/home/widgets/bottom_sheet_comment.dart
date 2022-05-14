import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/home/widgets/comment_card.dart';
import 'package:cloudmate/src/ui/home/widgets/input_comment_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomSheetComment extends StatefulWidget {
  final PostModel postModel;
  const BottomSheetComment({required this.postModel});
  @override
  State<StatefulWidget> createState() => _BottomSheetCommentState();
}

class _BottomSheetCommentState extends State<BottomSheetComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
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
                      onPressed: () {},
                      icon: Icon(
                        null,
                        color: colorPrimary,
                        size: 20.sp,
                      ),
                    ),
                    Text(
                      'Bình luận',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('comments')
                      .where('postId', isEqualTo: widget.postModel.id)
                      .orderBy('createdBy', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    }

                    List<QueryDocumentSnapshot> comments = snapshot.data?.docs ?? [];

                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) => CommentCard(
                        snapshot: comments[index],
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              BottomInputCommentInPost(
                postModel: widget.postModel,
              ),
              SizedBox(height: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}
