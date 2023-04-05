import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:cloudmate/src/ui/navigation/widgets/notification_card.dart';
import 'package:cloudmate/src/ui/notification/blocs/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..add(GetNotificationEvent()),
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial) {
            return LoadingScreen();
          }

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
                'Thông báo',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontFamily.lato,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ),
            body: Container(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.props[0].length,
                      itemBuilder: (context, index) {
                        return NotificationCard(
                          notification: state.props[0][index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
