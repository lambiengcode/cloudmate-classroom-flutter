import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/count_down/count_down_bloc.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/lobby_user_card.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class LobbyScreen extends StatefulWidget {
  final String roomId;
  const LobbyScreen({required this.roomId});
  @override
  State<StatefulWidget> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoExamBloc, DoExamState>(
      builder: (context, state) {
        if (state is InLobby) {
          return WillPopScope(
            onWillPop: () async {
              AppBloc.doExamBloc.add(QuitQuizEvent());
              return true;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                systemOverlayStyle: ThemeService.systemBrightness,
                centerTitle: true,
                elevation: .0,
                leading: IconButton(
                  onPressed: () => AppBloc.doExamBloc.add(QuitQuizEvent()),
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
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (state.users.isEmpty) {
                        print('Users: 0');
                      } else {}
                    },
                    icon: Icon(
                      PhosphorIcons.circleWavyWarningFill,
                      size: 20.sp,
                      color: Theme.of(context).primaryColor,
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
                      SizedBox(height: 6.sp),
                      Expanded(
                        child: _buildBodyLobby(context, state),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return LoadingScreen();
      },
    );
  }

  Widget _buildBodyLobby(context, InLobby state) {
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
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return LobbyUserCard(
                userModel: state.users[index],
              );
            },
          ),
        ),
        SizedBox(height: 20.sp),
        Text(
          'Bắt đầu trong',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.75),
            fontFamily: FontFamily.lato,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.sp),
        BlocBuilder<CountDownBloc, CountDownState>(
          builder: (context, state) {
            return Text(
              state is InProgressCountDown ? '${state.duration}' : '30',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: FontFamily.lato,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
        SizedBox(height: 4.sp),
        Text(
          'giây nữa',
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
