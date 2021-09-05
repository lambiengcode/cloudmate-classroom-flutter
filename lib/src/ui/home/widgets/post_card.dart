import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:flutter_mobile_2school/src/ui/home/widgets/exam_in_post.dart';
import 'package:flutter_mobile_2school/src/utils/blurhash.dart';
import 'package:like_button/like_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class PostCard extends StatefulWidget {
  final String idPost;
  final bool isInDetails;
  PostCard({required this.idPost, this.isInDetails = false});
  @override
  State<StatefulWidget> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();
  int likeCount = 555;
  bool isLiked = false;

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    setState(() {
      this.isLiked = !this.isLiked;
    });

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
        border: Border(
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
          IconButton(
            icon: Icon(
              PhosphorIcons.bookmark,
              size: 25.sp,
            ),
            onPressed: () => null,
          )
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                'Nhớ đúng giờ nha các bạn',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 6.sp),
            // ImageBodyPost(
            //   blurHashs: [''],
            //   images: ['https://avatars.githubusercontent.com/u/60530946?v=4'],
            // ),
            ExamInPost(),
            SizedBox(height: 12.sp),
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
                  LikeButton(
                    key: _globalKey,
                    isLiked: isLiked,
                    likeCountAnimationType: likeCount < 1000
                        ? LikeCountAnimationType.part
                        : LikeCountAnimationType.none,
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
                    likeCount: isLiked ? likeCount + 1 : likeCount,
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
                    onTap: onLikeButtonTapped,
                  ),
                  SizedBox(width: 16.0),
                  _buildActionButton(
                    context,
                    'Comment',
                    PhosphorIcons.chatTeardropDots,
                    colorDarkGrey,
                    '229',
                  ),
                ],
              ),
              _buildActionButton(
                context,
                'Share',
                PhosphorIcons.share,
                colorDarkGrey,
                null,
              ),
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
        if (title == 'Comment') {
          if (widget.isInDetails) {
            print('scroll end');
          } else {}
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
              hash: '',
              image:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzy6LtbJQP3wf-qBbtsfO1zJO3q_RZp59Yow&usqp=CAU',
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
              'Flutter Class',
              style: TextStyle(
                fontSize: 12.25.sp,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.15.sp),
            Text(
              'lambiengcode',
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
