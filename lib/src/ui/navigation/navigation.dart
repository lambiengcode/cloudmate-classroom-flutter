import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/services/socket/socket.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/calendar/calendar_screen.dart';
import 'package:cloudmate/src/ui/chats/chat_screen.dart';
import 'package:cloudmate/src/ui/classes/classes_screen.dart';
import 'package:cloudmate/src/ui/home/home_screen.dart';
import 'package:cloudmate/src/ui/profile/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class Navigation extends StatefulWidget {
  final int initialIndex;
  Navigation({this.initialIndex = 0});
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;
  var _pages = [
    HomeScreen(),
    ClassesScreen(),
    ChatScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialIndex;
    // Future.delayed(Duration(milliseconds: 800), () async {
    //   LanguageService().initialLanguage(context);
    // });

    AppBloc.authBloc.add(GetInfoUser());
    connectAndListen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).scaffoldBackgroundColor,
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
                    'Classes',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.chatsTeardrop,
                    PhosphorIcons.chatsTeardropFill,
                    2,
                    'Message',
                  ),
                  _buildItemBottomBar(
                    PhosphorIcons.clock,
                    PhosphorIcons.alarmBold,
                    3,
                    'Calendar',
                  ),
                  _buildItemBottomAccount(
                    state is AuthenticationSuccess
                        ? (state.userModel?.image ?? Constants.urlImageDefault)
                        : Constants.urlImageDefault,
                    state is AuthenticationSuccess ? (state.userModel?.blurHash ?? '') : '',
                    4,
                  ),
                ],
              ),
            ),
          ),
          body: _pages[currentPage],
        );
      },
    );
  }

  Widget _buildItemBottomBar(inActiveIcon, activeIcon, index, title) {
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
              Container(
                color: Colors.transparent,
                child: Icon(
                  index == currentPage ? activeIcon : inActiveIcon,
                  size: 21.5.sp,
                  color: index == currentPage
                      ? colorPrimary
                      : Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              SizedBox(height: 2.5.sp),
              Container(
                height: 4.sp,
                width: 4.sp,
                decoration: BoxDecoration(
                  color: index == 10 ? colorPrimary : Colors.transparent,
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
    blurHash,
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
                    height: 24.sp,
                    width: 24.sp,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentPage == index ? colorPrimary : Colors.transparent,
                        width: 1.8.sp,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.sp),
                      child: BlurHash(
                        hash: blurHash,
                        image: urlToImage,
                        imageFit: BoxFit.cover,
                        color: colorPrimary,
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
                  color: index == 2 ? colorPrimary : Colors.transparent,
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
