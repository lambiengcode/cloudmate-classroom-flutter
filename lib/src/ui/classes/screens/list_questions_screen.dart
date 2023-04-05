import 'package:cloudmate/src/helpers/export_excel.dart';
import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/question/question_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/question_card.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ListQuestionScreen extends StatefulWidget {
  final ExamModel examModel;
  const ListQuestionScreen({required this.examModel});
  @override
  State<StatefulWidget> createState() => _ListQuestionScreenState();
}

class _ListQuestionScreenState extends State<ListQuestionScreen> {
  late QuestionBloc _questionBloc;

  @override
  void initState() {
    super.initState();
    _questionBloc = QuestionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionBloc>(
      create: (context) => _questionBloc
        ..add(GetListQuestionEvent(
          examId: widget.examModel.id,
        )),
      child: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
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
                widget.examModel.name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontFamily.lato,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    List<QuestionModel> questions = await pickFileExcel();
                    showDialogLoading(context);
                    _questionBloc.add(
                      ImportQuestionsEvent(
                        context: context,
                        examId: widget.examModel.id,
                        questions: questions,
                      ),
                    );
                  },
                  icon: Icon(
                    PhosphorIcons.fileArrowUp,
                    size: 20.sp,
                    color: colorAttendance,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AppNavigator.push(AppRoutes.CREATE_QUESTION, arguments: {
                      'questionBloc': _questionBloc,
                      'examId': widget.examModel.id,
                    });
                  },
                  icon: Icon(
                    PhosphorIcons.circlesThreePlus,
                    size: 20.sp,
                    color: colorPrimary,
                  ),
                ),
              ],
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
                    child: state is QuestionInitial
                        ? LoadingScreen()
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 16.sp),
                            physics: BouncingScrollPhysics(),
                            itemCount: state.props[0].length,
                            itemBuilder: (context, index) {
                              return QuestionCard(
                                question: state.props[0][index],
                                questionBloc: _questionBloc,
                                isLast: index == state.props[0].length - 1,
                                index: index + 1,
                                examId: widget.examModel.id,
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
