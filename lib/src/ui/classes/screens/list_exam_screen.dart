import 'package:cloudmate/src/models/exam.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/exam/exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/exam_card.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ListExamScreen extends StatefulWidget {
  final String classId;
  ListExamScreen({required this.classId});
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
      create: (_) => _examBloc..add(GetListExamEvent(classId: widget.classId)),
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
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  AppNavigator.push(AppRoutes.CREATE_EXAM, arguments: {
                    'classId': widget.classId,
                    'examBloc': _examBloc,
                  });
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
            child: Column(
              children: [
                SizedBox(height: 2.5.sp),
                Divider(
                  height: .25,
                  thickness: .25,
                ),
                SizedBox(height: 6.sp),
                Expanded(
                  child: state is ExamInitial ? LoadingScreen() : _buildListExam(context, state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListExam(context, ExamState state) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 16.sp),
      physics: BouncingScrollPhysics(),
      itemCount: state.props[0].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            AppNavigator.push(
              AppRoutes.LIST_QUESTION,
            );
          },
          child: ExamCard(
            exam: exams[index],
            isLast: index == exams.length - 1,
          ),
        );
      },
    );
  }
}
