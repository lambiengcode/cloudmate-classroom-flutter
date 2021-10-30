import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/hard/hard_post.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/lobby_user_card.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class LobbyScreen extends StatefulWidget {
  final String roomId;
  const LobbyScreen({required this.roomId});
  @override
  State<StatefulWidget> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => AppNavigator.pop(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          'ID: ${widget.roomId}',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => AppBloc.doExamBloc.add(StartQuizEvent()),
            icon: Icon(
              PhosphorIcons.circleWavyWarningFill,
              size: 20.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: BlocBuilder<DoExamBloc, DoExamState>(
        builder: (context, state) {
          if (state is InLobby) {
            return Container(
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
                    SizedBox(height: 6.sp),
                    Expanded(
                      child: _buildBodyLobby(context),
                    ),
                  ],
                ),
              ),
            );
          }

          return LoadingScreen();
        },
      ),
    );
  }

  Widget _buildBodyLobby(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20.sp),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 16.sp,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return LobbyUserCard(
                userModel: UserModel(
                  id: 'lambiengcode',
                  displayName: 'Dao Hong Vinh',
                  lastName: 'Hong Vinh',
                  image: 'https://avatars.githubusercontent.com/u/50282063?s=200&v=4',
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.sp),
        Text(
          'Start in',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.75),
            fontFamily: FontFamily.lato,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.sp),
        Text(
          '60',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: FontFamily.lato,
            fontSize: 25.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.sp),
        Text(
          'seconds',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: FontFamily.lato,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6.sp),
      ],
    );
  }
}
