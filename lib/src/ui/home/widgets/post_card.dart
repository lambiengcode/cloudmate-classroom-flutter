import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/ui/home/widgets/bottom_sheet_comment.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/home/widgets/attendance_in_post.dart';
import 'package:cloudmate/src/ui/home/widgets/deadline_in_post.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:like_button/like_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final bool isInDetails;
  final bool isLast;
  PostCard({required this.post, this.isInDetails = false, this.isLast = false});
  @override
  State<StatefulWidget> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();
  bool isSaved = false;

  Future<bool> onLikeButtonTapped({required bool isLiked, DocumentReference? snapshot}) async {
    if (!isLiked) {
      await FirebaseFirestore.instance.collection('favourites').add({
        'postId': widget.post.id,
        'userId': AppBloc.authBloc.userModel?.id,
      });
    } else {
      if (snapshot != null) {
        await snapshot.delete();
      }
    }

    return !isLiked;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.sp,
        bottom: widget.isInDetails ? 12.sp : 4.sp,
      ),
      decoration: BoxDecoration(
        border: widget.isLast
            ? null
            : Border(
                bottom: BorderSide(
                  width: .3,
                  color: Theme.of(context).dividerColor,
                ),
              ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildBody(context),
          _buildBottom(context),
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.sp, right: 4.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoWritter(context),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.sp),
            Column(
              children: [
                SizedBox(height: 4.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text(
                    widget.post.roadMapContent?.name ?? widget.post.content ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 6.sp),
              ],
            ),
            widget.post.roadMapContent == null
                ? SizedBox()
                : widget.post.roadMapContent!.type == RoadMapContentType.attendance
                    ? AttendanceInPost(
                        roadMapContent: widget.post.roadMapContent!,
                        isAdmin:
                            AppBloc.authBloc.userModel?.id == widget.post.classModel.createdBy?.id,
                        quantityMembers: widget.post.classModel.totalMember,
                      )
                    : DeadlineInPost(
                        roadMapContent: widget.post.roadMapContent!,
                        isAdmin:
                            AppBloc.authBloc.userModel?.id == widget.post.classModel.createdBy?.id,
                        quantityMembers: widget.post.classModel.totalMember,
                      ),
            SizedBox(height: 2.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 6.sp),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('favourites')
                        .where('postId', isEqualTo: widget.post.id)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      List<QueryDocumentSnapshot> likes = snapshot.data?.docs ?? [];
                      int indexOfLiked =
                          likes.indexWhere((e) => e['userId'] == AppBloc.authBloc.userModel?.id);
                      bool isLiked = indexOfLiked != -1;

                      return LikeButton(
                        key: _globalKey,
                        isLiked: isLiked,
                        likeCountAnimationType: LikeCountAnimationType.none,
                        size: 18.sp,
                        circleColor: CircleColor(
                          start: Color(0xff00ddff),
                          end: Color(0xff0099cc),
                        ),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: colorHigh,
                          dotSecondaryColor: colorHigh,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked ? PhosphorIcons.heartFill : PhosphorIcons.heart,
                            color: isLiked ? colorHigh : null,
                            size: 18.sp,
                          );
                        },
                        likeCount: likes.length,
                        countBuilder: (int? count, bool isLiked, String text) {
                          var color = isLiked ? colorHigh : null;
                          Widget result;
                          result = Text(
                            text,
                            style: TextStyle(
                              color: color,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.lato,
                            ),
                          );

                          return result;
                        },
                        likeCountPadding: EdgeInsets.only(left: 6.sp),
                        onTap: (isLiked) => onLikeButtonTapped(
                          isLiked: isLiked,
                          snapshot: likes.isNotEmpty && indexOfLiked != -1
                              ? likes[indexOfLiked].reference
                              : null,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 16.0),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('comments')
                        .where('postId', isEqualTo: widget.post.id)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return _buildActionButton(
                        context,
                        'Comments',
                        PhosphorIcons.chat,
                        colorDarkGrey,
                        snapshot.data?.docs.length ?? 0,
                      );
                    },
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  // isSaved ? PhosphorIcons.bookmarkFill : PhosphorIcons.bookmark,
                  null,
                  size: 20.sp,
                  color: isSaved
                      ? themeService.isSavedDarkMode()
                          ? Colors.amberAccent
                          : Colors.amberAccent.shade700
                      : null,
                ),
                onPressed: () {
                  // setState(() {
                  //   isSaved = !isSaved;
                  // });
                },
              )
            ],
          ),
          SizedBox(height: 8.sp),
          // _buildLineFavouritePost(context),
        ],
      ),
    );
  }

  Widget _buildActionButton(context, title, icon, color, value) {
    return GestureDetector(
      onTap: () {
        if (title == 'Comments') {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => BottomSheetComment(postModel: widget.post),
          );
        } else {}
      },
      child: Container(
        child: Row(
          children: [
            SizedBox(width: 4.sp),
            Icon(
              icon,
              size: 18.sp,
            ),
            SizedBox(width: 4.sp),
            title == 'Share'
                ? Container()
                : Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.lato,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Widget _buildLineFavouritePost(context) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 1.sp, right: 5.sp),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         StackAvatar(
  //           images: [
  //             'https://avatars.githubusercontent.com/u/60530946?v=4',
  //             'https://avatars.githubusercontent.com/u/60530946?v=4',
  //             'https://avatars.githubusercontent.com/u/60530946?v=4',
  //           ],
  //         ),
  //         SizedBox(width: 6.sp),
  //         Expanded(
  //           child: RichText(
  //             text: TextSpan(
  //               children: [
  //                 TextSpan(
  //                   text: 'Harold, Kim, Bạn',
  //                   style: TextStyle(
  //                     fontFamily: FontFamily.lato,
  //                     fontSize: 11.sp,
  //                     fontWeight: FontWeight.w600,
  //                     color: Theme.of(context).textTheme.bodyText1!.color,
  //                   ),
  //                 ),
  //                 TextSpan(
  //                   text: '\tvà\t',
  //                   style: TextStyle(
  //                     fontFamily: FontFamily.lato,
  //                     fontSize: 11.sp,
  //                     fontWeight: FontWeight.w400,
  //                     color: Theme.of(context).textTheme.bodyText1!.color,
  //                   ),
  //                 ),
  //                 TextSpan(
  //                   text: '885 người khác',
  //                   style: TextStyle(
  //                     fontFamily: FontFamily.lato,
  //                     fontSize: 11.sp,
  //                     fontWeight: FontWeight.w600,
  //                     color: Theme.of(context).textTheme.bodyText1!.color,
  //                   ),
  //                 ),
  //                 TextSpan(
  //                   text: '\tđã yêu thích bài viết này',
  //                   style: TextStyle(
  //                     fontFamily: FontFamily.lato,
  //                     fontSize: 11.sp,
  //                     fontWeight: FontWeight.w400,
  //                     color: Theme.of(context).textTheme.bodyText1!.color,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildInfoWritter(context) {
    return Row(
      children: [
        Container(
          height: 28.sp,
          width: 28.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.sp),
            child: BlurHash(
              hash: widget.post.classModel.blurHash,
              image: widget.post.classModel.image,
              imageFit: BoxFit.cover,
              color: colorPrimary,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.post.classModel.name,
              style: TextStyle(
                fontSize: 12.25.sp,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.15.sp),
            Text(
              widget.post.createdBy.displayName ?? 'Author',
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
