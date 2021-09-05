import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/ui/common/network_cached.dart';
import 'package:flutter_mobile_2school/src/ui/home/home_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class Navigation extends StatefulWidget {
  final int initialIndex;
  Navigation({this.initialIndex = 0});
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;
  bool _loading = false;
  var _pages = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Scaffold(
            bottomNavigationBar: BottomAppBar(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: mCL,
              elevation: .0,
              child: Container(
                height: 48.sp,
                padding: EdgeInsets.symmetric(horizontal: 6.5.sp),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: .2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _buildItemBottomBar(
                      PhosphorIcons.house,
                      PhosphorIcons.houseFill,
                      0,
                      'Home',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.graduationCap,
                      PhosphorIcons.graduationCapFill,
                      1,
                      'Search',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.chatsTeardrop,
                      PhosphorIcons.chatsTeardropFill,
                      2,
                      'Message',
                    ),
                    _buildItemBottomBar(
                      PhosphorIcons.bell,
                      PhosphorIcons.bellBold,
                      3,
                      'Notifications',
                    ),
                    _buildItemBottomAccount(
                      'https://avatars.githubusercontent.com/u/60530946?v=4',
                      4,
                    ),
                  ],
                ),
              ),
            ),
            body: _pages[currentPage],
          );
  }

  Widget _buildItemBottomBar(inActiveIcon, activeIcon, index, title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentPage = index;
          });
          if (index == 0) {
            // showIncommingCallBottomSheet();
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                child: Icon(
                  index == currentPage ? activeIcon : inActiveIcon,
                  size: 21.5.sp,
                  color: index == currentPage ? colorPrimary : colorTitle,
                ),
              ),
              SizedBox(height: 2.5.sp),
              Container(
                height: 4.sp,
                width: 4.sp,
                decoration: BoxDecoration(
                  color: index == 3 ? colorPrimary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemBottomAccount(
    urlToImage,
    index,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentPage = index;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentPage == index
                            ? colorPrimary
                            : Colors.transparent,
                        width: 1.8.sp,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        height: 20.sp,
                        width: 20.sp,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => PlaceHolderImage(),
                        errorWidget: (context, url, error) =>
                            ErrorLoadingImage(),
                        imageUrl: urlToImage,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.sp),
              Container(
                height: 4.sp,
                width: 4.sp,
                decoration: BoxDecoration(
                  color: index == 3 ? colorPrimary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
