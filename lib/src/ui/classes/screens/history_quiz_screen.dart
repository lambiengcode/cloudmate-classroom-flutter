import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class HistoryQuizScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryQuizScreenState();
}

class _HistoryQuizScreenState extends State<HistoryQuizScreen> {
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
          'Bộ đề kiểm tra',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [],
      ),
    );
  }
}
