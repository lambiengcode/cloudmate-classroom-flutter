import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/share_exam/share_exam_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/exam.dart';
import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/exam/exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ListExamScreen extends StatefulWidget {
  final ClassModel classModel;
  final bool isPickedMode;
  ListExamScreen({required this.classModel, this.isPickedMode = false});
  @override
  State<StatefulWidget> createState() => _ListExamScreenState();
}

class _ListExamScreenState extends State<ListExamScreen> {
  late ExamBloc _examBloc;

  @override
  void initState() {
    super.initState();
    _examBloc = ExamBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExamBloc>(
      create: (_) => _examBloc..add(GetListExamEvent(classId: widget.classModel.id)),
      child: BlocBuilder<ExamBloc, ExamState>(
        builder: (_, state) => Scaffold(
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
              'Bộ đề kiểm tra',
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            actions: [
              widget.isPickedMode
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        AppNavigator.push(AppRoutes.CREATE_EXAM, arguments: {
                          'classId': widget.classModel.id,
                          'examBloc': _examBloc,
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  SizedBox(height: 6.sp),
                  state is ExamInitial ? SizedBox() : _buildListExam(context, state),
                  BlocBuilder<ShareExamBloc, ShareExamState>(builder: (context, state1) {
                    return state1 is GetDoneShareExam
                        ? _buildListExamModel(context, state1)
                        : SizedBox();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListExam(context, ExamState state) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: state.props[0].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (widget.isPickedMode) {
              AppBloc.doExamBloc.add(
                CreateQuizEvent(
                  examId: state.props[0][index].id,
                  classId: widget.classModel.id,
                  title: 'title',
                  description: 'description',
                ),
              );
            } else {
              AppNavigator.push(
                AppRoutes.LIST_QUESTION,
                arguments: {
                  'examModel': state.props[0][index],
                },
              );
            }
          },
          child: ExamCard(
            exam: state.props[0][index],
            isLast: index == exams.length - 1,
            isPickedMode: widget.isPickedMode,
          ),
        );
      },
    );
  }

  Widget _buildListExamModel(context, GetDoneShareExam state) {
    List<ExamModel> exams = [];

    state.exams.forEach((exam) {
      if (widget.classModel.setOfQuestionShare?.indexWhere((element) => element == exam.id) != -1) {
        exams.add(exam);
      }
    });

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 16.sp),
      physics: BouncingScrollPhysics(),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (widget.isPickedMode) {
              AppBloc.doExamBloc.add(
                CreateQuizEvent(
                  examId: exams[index].id,
                  classId: widget.classModel.id,
                  title: 'title',
                  description: 'description',
                ),
              );
            } else {
              AppNavigator.push(
                AppRoutes.LIST_QUESTION,
                arguments: {
                  'examModel': exams[index],
                },
              );
            }
          },
          child: ExamCard(
            exam: exams[index],
            isLast: index == exams.length - 1,
            isShareCard: true,
          ),
        );
      },
    );
  }
}
