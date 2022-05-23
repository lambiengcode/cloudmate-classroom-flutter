import 'package:cloudmate/src/ui/home/widgets/new_post.dart';
import 'package:cloudmate/src/ui/home/widgets/post_shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class PostShimmerList extends StatelessWidget {
  final bool isShowNewPost;
  const PostShimmerList({this.isShowNewPost = true});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: isShowNewPost
          ? EdgeInsets.only(top: 12.sp, bottom: 20.sp)
          : EdgeInsets.only(bottom: 80.sp),
      itemCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return index == (isShowNewPost ? 0 : -1) ? NewPost() : PostShimmerCard(isLast: index == 2);
      },
    );
  }
}
