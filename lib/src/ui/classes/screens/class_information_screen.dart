import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloudmate/src/resources/hard/hard_chat.dart';
import 'package:cloudmate/src/resources/hard/hard_post.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/home/widgets/post_card.dart';
import 'package:cloudmate/src/utils/stack_avatar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ClassInformationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClassInformationScreenState();
}

class _ClassInformationScreenState extends State<ClassInformationScreen> {
  ScrollController scrollController = ScrollController();
  double heightOfClassImage = 38.h;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        setState(() {
          heightOfClassImage = 38.h;
        });
      } else {
        setState(() {
          heightOfClassImage = 38.h / scrollController.offset;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 180),
                      curve: Curves.fastOutSlowIn,
                      height: heightOfClassImage,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(35.sp),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://i.pinimg.com/originals/02/89/09/02890993e3735184e80ecdf9db079e05.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35.sp,
                      left: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(9.25.sp),
                              margin: EdgeInsets.only(left: 10.sp),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.15),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Icon(
                                PhosphorIcons.arrowLeftBold,
                                size: 18.sp,
                                color: mC,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(9.25.sp),
                              margin: EdgeInsets.only(right: 10.sp),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.15),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Icon(
                                PhosphorIcons.slidersHorizontal,
                                size: 18.sp,
                                color: mC,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.sp),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.sp, right: 12.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      posts[1].groupName + ' - \nBeginner',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: FontFamily.lato,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Row(
                                      children: [
                                        StackAvatar(
                                          size: 22.sp,
                                          images: chats
                                              .sublist(3, 6)
                                              .map((e) => e.image!)
                                              .toList(),
                                        ),
                                        SizedBox(width: 6.sp),
                                        Text(
                                          '40 học viên',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: FontFamily.lato,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$ Free',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: FontFamily.lato,
                                  fontWeight: FontWeight.w600,
                                  color: colorPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.sp),
                        Container(
                          padding: EdgeInsets.only(left: 10.sp, right: 12.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Intro',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: FontFamily.lato,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              Text(
                                'This is a class for a beginner in Flutter. You will learn about the basic'
                                ' of object structure and some mobile application. Join with us today.',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: FontFamily.lato,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color!
                                      .withOpacity(.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.sp),
                        Container(
                          padding: EdgeInsets.only(left: 10.sp, right: 12.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Posts',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: FontFamily.lato,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            bottom: 80.sp,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              post: posts[index],
                              isLast: index == posts.length - 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: AppDecoration.containerOnlyShadowTop(context).decoration,
        padding: EdgeInsets.only(bottom: 18.sp, top: 8.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 18.sp),
            Container(
              width: 70.w,
              height: 42.sp,
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(8.sp),
              ),
              alignment: Alignment.center,
              child: Text(
                'Enroll Class',
                style: TextStyle(
                  color: mC,
                  fontFamily: FontFamily.lato,
                  fontSize: 12.75.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 40.sp,
              height: 42.sp,
              decoration: BoxDecoration(
                color: Colors.amberAccent.shade700,
                borderRadius: BorderRadius.circular(8.sp),
              ),
              alignment: Alignment.center,
              child: Icon(
                PhosphorIcons.bookmarkFill,
                color: mC,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 18.sp),
          ],
        ),
      ),
    );
  }
}
