import 'dart:math';

import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:sizer/sizer.dart';

class RoadMapScreen extends StatefulWidget {
  @override
  _RoadMapScreenState createState() => _RoadMapScreenState();
}

class _RoadMapScreenState extends State<RoadMapScreen> {
  List<Step>? _steps;

  @override
  void initState() {
    _steps = _generateData();
    super.initState();
  }

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
          'Flutter Beginner',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => AppNavigator.push(AppRoutes.CREATE_DEADLINE),
            icon: Icon(
              PhosphorIcons.circlesThreePlus,
              size: 22.sp,
              color: colorPrimary,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 12.sp),
        child: Column(
          children: <Widget>[
            SizedBox(height: 2.5.sp),
            Divider(
              height: .25,
              thickness: .25,
            ),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[_TimelineSteps(steps: _steps!)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> _generateData() {
    return <Step>[
      const Step(
        step: 1,
        title: 'Decide What You Want',
        message:
            'Step number one, decide exactly what it is you want in each part of your life. Become a "meaningful specific" rather than a "wandering generality."',
      ),
      const Step(
        step: 2,
        title: 'Write it Down',
        message:
            'Second, write it down, clearly and in detail. Always think on paper. A goal that is not in writing is not a goal at all. It is merely a wish and it has no energy behind it.',
      ),
      const Step(
        step: 3,
        title: 'Set a Deadline',
        message:
            'Third, set a deadline for your goal. A deadline acts as a "forcing system” in your subconscious mind. It motivates you to do the things necessary to make your goal come true. If it is a big enough goal, set sub-deadlines as well. Don’t leave this to chance.',
      ),
      const Step(
        step: 4,
        title: 'Make a List',
        message:
            'Fourth, make a list of everything that you can think of that you are going to have to do to achieve your goal. When you think of new tasks and activities, write them on your list until your list is complete.',
      ),
      const Step(
        step: 5,
        title: 'Organize Your List',
        message:
            'Fifth, organize your list into a plan. Decide what you will have to do first and what you will have to do second. Decide what is more important and what is less important. And then write out your plan on paper, the same way you would develop a blueprint to build your dream house.',
      ),
      const Step(
        step: 6,
        title: 'Take Action',
        message:
            'The sixth step is for you to take action on your plan. Do something. Do anything. But get busy. Get going.',
      ),
      const Step(
        step: 7,
        title: 'Do Something Every Day',
        message:
            'Do something every single day that moves you in the direction of your most important goal at the moment. Develop the discipline of doing something 365 days each year that is moving you forward. You will be absolutely astonished at how much you accomplish when you utilize this formula in your life every single day.',
      ),
      const Step(
        step: 7,
        title: 'Do Something Every Day',
        message:
            'Do something every single day that moves you in the direction of your most important goal at the moment. Develop the discipline of doing something 365 days each year that is moving you forward. You will be absolutely astonished at how much you accomplish when you utilize this formula in your life every single day.',
      ),
      const Step(
        step: 7,
        title: 'Do Something Every Day',
        message:
            'Do something every single day that moves you in the direction of your most important goal at the moment. Develop the discipline of doing something 365 days each year that is moving you forward. You will be absolutely astonished at how much you accomplish when you utilize this formula in your life every single day.',
      ),
      const Step(
        step: 7,
        title: 'Do Something Every Day',
        message:
            'Do something every single day that moves you in the direction of your most important goal at the moment. Develop the discipline of doing something 365 days each year that is moving you forward. You will be absolutely astonished at how much you accomplish when you utilize this formula in your life every single day.',
      ),
    ];
  }
}

class _TimelineSteps extends StatelessWidget {
  const _TimelineSteps({required this.steps});

  final List<Step> steps;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd)
            return TimelineDivider(
              color: colorPrimary,
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );

          final int itemIndex = index ~/ 2;
          final Step step = steps[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            title: step.title!,
            subtitle: step.message!,
            isLeftAlign: isLeftAlign,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == steps.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.1 : 0.9,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicatorXY: indicatorY,
              indicator: _TimelineStepIndicator(step: '${step.step}'),
            ),
            beforeLineStyle: LineStyle(
              color: colorPrimary,
              thickness: 5,
            ),
          );
        },
        childCount: max(0, steps.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  const _TimelineStepIndicator({required this.step});

  final String step;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorPrimary,
      ),
      child: Center(
        child: Text(
          step,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TimelineStepsChild extends StatelessWidget {
  const _TimelineStepsChild({
    required this.title,
    required this.subtitle,
    required this.isLeftAlign,
  });

  final String title;
  final String subtitle;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign
          ? EdgeInsets.only(
              right: 26.sp,
              top: 12.sp,
              bottom: 12.sp,
              left: 6.sp,
            )
          : EdgeInsets.only(
              left: 26.sp,
              top: 12.sp,
              bottom: 12.sp,
              right: 6.sp,
            ),
      child: Column(
        crossAxisAlignment:
            isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.lato,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.sp),
          Text(
            subtitle,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 12.sp,
              color:
                  Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}

class Step {
  const Step({
    this.step,
    this.title,
    this.message,
  });

  final int? step;
  final String? title;
  final String? message;
}
