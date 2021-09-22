import 'package:cloudmate/src/models/exam.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/widgets/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ListExamScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListExamScreenState();
}

class _ListExamScreenState extends State<ListExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              Navigator.of(context).pushNamed(AppRoutes.CREATE_EXAM);
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
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 16.sp),
                physics: BouncingScrollPhysics(),
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  return ExamCard(
                    exam: exams[index],
                    isLast: index == exams.length - 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
