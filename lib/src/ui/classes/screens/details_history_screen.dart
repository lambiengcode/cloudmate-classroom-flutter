import 'package:cloudmate/src/helpers/export_excel.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/widgets/user_score_card.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DetailsHistoryScreen extends StatefulWidget {
  final String title;
  final int score;
  final List<UserModel> users;
  DetailsHistoryScreen({
    required this.title,
    required this.score,
    required this.users,
  });
  @override
  State<StatefulWidget> createState() => _DetailsHistoryScreenState();
}

class _DetailsHistoryScreenState extends State<DetailsHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => AppNavigator.pop(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => exportResultToExcel(widget.users, widget.score),
            icon: Icon(
              PhosphorIcons.export,
              size: 20.sp,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  itemCount: widget.users.length,
                  itemBuilder: (context, index) {
                    return UserScoreCard(
                      user: widget.users[index],
                      totalScore: widget.score,
                      isLast: index == widget.users.length - 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
