import 'package:cloudmate/src/helpers/export_excel.dart';
import 'package:cloudmate/src/models/statistic_model.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/user_score_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class StatisticFinalScreen extends StatefulWidget {
  final FinalStatisticModel statisticModel;
  StatisticFinalScreen({required this.statisticModel});
  @override
  State<StatefulWidget> createState() => _StatisticFinalScreenState();
}

class _StatisticFinalScreenState extends State<StatisticFinalScreen> {
  late DoExamBloc _doExamBloc;

  @override
  void initState() {
    super.initState();
    _doExamBloc = BlocProvider.of<DoExamBloc>(context);
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
          onPressed: () =>
              exportResultToExcel(widget.statisticModel.users, widget.statisticModel.totalScore),
          icon: Icon(
            PhosphorIcons.export,
            size: 20.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          'Thống kê tổng quan',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _doExamBloc.add(QuitQuizEvent()),
            icon: Icon(
              PhosphorIcons.signOut,
              size: 20.sp,
              color: colorHigh,
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
                  itemCount: widget.statisticModel.users.length,
                  itemBuilder: (context, index) {
                    return UserScoreCard(
                      user: widget.statisticModel.users[index],
                      totalScore: widget.statisticModel.totalScore,
                      isLast: index == widget.statisticModel.users.length - 1,
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
