import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class SubmitDeadlineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubmitDeadlineScreenState();
}

class _SubmitDeadlineScreenState extends State<SubmitDeadlineScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.sp),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.sp),
            Container(
              child: Text(
                '\tBài tập về nhà tuần 7',
                style: TextStyle(
                  fontFamily: FontFamily.lato,
                  fontSize: 12.75.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16.sp),
            GestureDetector(
              onTap: () async {},
              child: Container(
                height: 48.sp,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: AppDecoration.buttonActionBorderActive(context, 8.sp).decoration,
                child: Row(
                  children: [
                    SizedBox(width: 6.sp),
                    Expanded(
                      child: Text(
                        'btvn-tuan-6.docx',
                        style: TextStyle(
                          fontFamily: FontFamily.lato,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Container(
                      height: 32.sp,
                      width: 32.sp,
                      decoration: BoxDecoration(
                        color: colorHigh,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        PhosphorIcons.folderNotchOpenFill,
                        size: 15.sp,
                        color: mC,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            GestureDetector(
              onTap: () async {
                AppNavigator.pop();
              },
              child: Container(
                height: 38.sp,
                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  color: colorPrimary,
                ),
                child: Center(
                  child: Text(
                    'Nộp bài',
                    style: TextStyle(
                      color: mC,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.sp),
          ],
        ),
      ),
    );
  }
}
