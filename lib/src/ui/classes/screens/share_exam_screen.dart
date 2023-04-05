import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/share_exam/share_exam_bloc.dart';
import 'package:cloudmate/src/models/exam.dart';
import 'package:cloudmate/src/models/slide_mode.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/widgets/exam_card.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ShareExamScreen extends StatefulWidget {
  ShareExamScreen();
  @override
  State<StatefulWidget> createState() => _ShareExamScreenState();
}

class _ShareExamScreenState extends State<ShareExamScreen> {
  @override
  void initState() {
    super.initState();
    AppBloc.shareExamBloc.add(GetShareExamEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareExamBloc, ShareExamState>(
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
            IconButton(
              onPressed: () {
                AppNavigator.push(
                  AppRoutes.CREATE_EXAM,
                  arguments: {
                    'slide': SlideMode.right,
                  },
                );
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
                child: state is GetDoneShareExam ? _buildListExam(context, state) : LoadingScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListExam(context, GetDoneShareExam state) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 16.sp),
      physics: BouncingScrollPhysics(),
      itemCount: state.exams.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            AppNavigator.push(
              AppRoutes.LIST_QUESTION,
              arguments: {
                'examModel': state.exams[index],
              },
            );
          },
          child: ExamCard(
            exam: state.exams[index],
            isLast: index == exams.length - 1,
            isShareCard: true,
          ),
        );
      },
    );
  }
}
