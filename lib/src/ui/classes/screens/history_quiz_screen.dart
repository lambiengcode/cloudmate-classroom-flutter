import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/remote/history_quiz_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/history_quiz/history_quiz_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/history_quiz_item.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class HistoryQuizScreen extends StatefulWidget {
  final String classId;
  const HistoryQuizScreen({required this.classId});
  @override
  State<StatefulWidget> createState() => _HistoryQuizScreenState();
}

class _HistoryQuizScreenState extends State<HistoryQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryQuizBloc()
        ..add(
          GetHistoryQuizEvent(classId: widget.classId),
        ),
      child: BlocBuilder<HistoryQuizBloc, HistoryQuizState>(
        builder: (context, state) {
          if (state is HistoryQuizInitial) {
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
                'Lịch sử kiểm tra',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontFamily.lato,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  SizedBox(height: 6.sp),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 16.sp),
                      physics: BouncingScrollPhysics(),
                      itemCount: state.props[0].length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            showDialogLoading(context);
                            List<UserModel>? users = await HistoryQuizRepository()
                                .getDetailsHistory(quizId: state.props[0][index].id);
                            AppNavigator.pop();
                            AppNavigator.push(
                              AppRoutes.DETAILS_HISTORY_EXAM,
                              arguments: {
                                'users': users,
                                'title': state.props[0][index].title,
                                'score': state.props[0][index].score,
                              },
                            );
                          },
                          child: HistoryQuizCard(
                            historyQuizModel: state.props[0][index],
                            index: index + 1,
                            isLast: index == state.props[0].length - 1,
                          ),
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
