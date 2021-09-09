import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/resources/hard/hard_post.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/app_decorations.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:flutter_mobile_2school/src/ui/classes/widgets/recommend_class_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController();
  bool _showInfo = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset < 8.0) {
        if (!_showInfo) {
          setState(() {
            _showInfo = true;
          });
        }
      } else {
        if (_showInfo) {
          setState(() {
            _showInfo = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Colors.transparent,
        elevation: .0,
        centerTitle: true,
        leading: IconButton(
          splashColor: colorPrimary,
          splashRadius: 5.0,
          icon: Icon(
            PhosphorIcons.slidersHorizontal,
            size: 22.5.sp,
          ),
          onPressed: () => null,
        ),
        title: Text(
          _showInfo ? '' : 'Đào Hồng Vinh',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.lato,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 10.0,
            icon: Icon(
              PhosphorIcons.rows,
              size: 22.5.sp,
            ),
            onPressed: () => null,
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => null,
              child: Container(
                width: 100.w,
                alignment: Alignment.center,
                child: Container(
                  height: 108.sp,
                  width: 108.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorPrimary,
                      width: 3.sp,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    height: 96.sp,
                    width: 96.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://avatars.githubusercontent.com/u/60530946?v=4',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _showInfo
                ? Column(
                    children: [
                      SizedBox(height: 10.sp),
                      Text(
                        'Đào Hồng Vinh',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontFamily.lato,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.sp),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        alignment: Alignment.center,
                        child: Text(
                          'Mobile App Developer (lambiengcode)',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontFamily: FontFamily.lato,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 18.sp),
                      _buildInfoBar(),
                    ],
                  )
                : Container(),
            SizedBox(height: 12.sp),
            _buildTitle(
              'Archive',
              PhosphorIcons.starFill,
              Colors.amberAccent.shade700,
            ),
            SizedBox(height: 4.sp),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.only(bottom: 12.sp),
                  physics: ClampingScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return RecommendClassCard(
                      imageClass: posts[index].imageGroup,
                      className: posts[index].groupName,
                      star: '4.5 / 5.0',
                      teacher: posts[index].authorName,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBar() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      padding: EdgeInsets.symmetric(vertical: 14.sp),
      decoration: AppDecoration.buttonActionBorder(context, 6.sp).decoration,
      child: Row(
        children: [
          _buildInfo(context, 'Archive', '88'),
          _buildCustomDivider(),
          _buildInfo(context, 'Learning', '593'),
          _buildCustomDivider(),
          _buildInfo(context, 'Friend', '241'),
        ],
      ),
    );
  }

  Widget _buildInfo(context, title, value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => null,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.lato,
                  fontSize: 10.75.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.9),
                ),
              ),
              SizedBox(height: 6.5.sp),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDivider() {
    return Container(
      height: 40.sp,
      child: VerticalDivider(
        width: .25,
        thickness: .25,
        color: colorPrimary,
      ),
    );
  }

  _buildTitle(title, icon, color) {
    return Container(
      padding: EdgeInsets.only(left: 16.sp, right: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: color,
              ),
              SizedBox(width: 6.sp),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.lato,
                  color: color,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => null,
            icon: Icon(
              PhosphorIcons.pushPinFill,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
