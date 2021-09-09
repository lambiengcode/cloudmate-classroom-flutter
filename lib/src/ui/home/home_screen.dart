import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/resources/hard/hard_post.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'package:flutter_mobile_2school/src/ui/home/widgets/new_post.dart';
import 'package:flutter_mobile_2school/src/ui/home/widgets/post_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            PhosphorIcons.slidersHorizontal,
            size: 22.sp,
          ),
        ),
        title: RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'Cloud',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.dancing,
                color: colorPrimary,
              ),
            ),
            TextSpan(
              text: 'mate',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.dancing,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        )),
        actions: [
          IconButton(
            onPressed: () => themeService.changeThemeMode(),
            icon: Icon(
              PhosphorIcons.qrCode,
              size: 24.sp,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              PhosphorIcons.bellSimple,
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.5.sp),
              Divider(
                height: .25,
                thickness: .25,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 12.sp, bottom: 20.sp),
                  physics: BouncingScrollPhysics(),
                  itemCount: posts.length + 1,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? NewPost()
                        : PostCard(
                            post: posts[index - 1],
                            isLast: index == posts.length,
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Container(
  //     height: 42.sp,
  //     decoration: AppDecoration.inputChatDecoration(context).decoration,
  //     padding: EdgeInsets.only(left: 16.sp),
  //     margin: EdgeInsets.symmetric(horizontal: 8.sp),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Icon(
  //           PhosphorIcons.magnifyingGlassBold,
  //           size: 13.5.sp,
  //           color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(
  //                 ThemeService().isSavedDarkMode() ? .7 : .65,
  //               ),
  //         ),
  //         SizedBox(width: 12.sp),
  //         Text(
  //           'Find your class...',
  //           style: TextStyle(
  //             color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(
  //                   ThemeService().isSavedDarkMode() ? .9 : .65,
  //                 ),
  //             fontSize: 11.5.sp,
  //             fontWeight: FontWeight.w400,
  //             fontFamily: FontFamily.lato,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
