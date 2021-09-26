import 'package:cloudmate/src/lang/language_service.dart';
import 'package:cloudmate/src/lang/localization.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloudmate/src/models/slide_mode.dart';
import 'package:cloudmate/src/resources/hard/hard_post.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/widgets/class_card.dart';
import 'package:cloudmate/src/ui/classes/widgets/recommend_class_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AppNavigator.push(AppRoutes.LIST_REQUEST);
          },
          icon: Icon(
            PhosphorIcons.slidersHorizontal,
            size: 22.sp,
          ),
        ),
        title: Text(
          classTitle.i18n,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.lato,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              LanguageService().switchLanguage(context);
            },
            icon: Icon(
              PhosphorIcons.magnifyingGlassBold,
              size: 20.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              AppNavigator.push(AppRoutes.CREATE_CLASS);
            },
            icon: Icon(
              Feather.plus_square,
              size: 20.sp,
              color: colorPrimary,
            ),
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(height: 2.5.sp),
            Divider(
              height: .25,
              thickness: .25,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 8.sp, bottom: 16.sp),
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? _buildCurrentClasses(context)
                      : RecommendClassCard(
                          imageClass: posts[index - 1].imageGroup,
                          className: posts[index - 1].groupName,
                          star: '4.5 / 5.0',
                          teacher: posts[index - 1].authorName,
                        );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  _buildCurrentClasses(context) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp),
      child: Column(
        children: [
          _buildTitle(
            yourClass.i18n,
            PhosphorIcons.chalkboardSimpleBold,
            themeService.isSavedDarkMode() ? colorAttendance : colorGreenLight,
          ),
          Container(
            height: 164.sp,
            width: 100.w,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      AppRoutes.DETAILS_CLASS,
                      arguments: {
                        'slide': SlideMode.bot,
                      },
                    );
                  },
                  child: ClassCard(
                    className: posts[index].groupName,
                    imageClass: posts[index].imageGroup,
                    teacher: posts[index].authorName,
                  ),
                );
              },
            ),
          ),
          _buildTitle(
            recommendClass.i18n,
            PhosphorIcons.presentationChartBold,
            colorPrimary,
          ),
        ],
      ),
    );
  }

  _buildTitle(title, icon, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18.sp,
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
            PhosphorIcons.squaresFour,
            size: 20.sp,
          ),
        ),
      ],
    );
  }
}
