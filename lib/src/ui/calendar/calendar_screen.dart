import 'package:flutter/material.dart';
import 'package:cloudmate/src/ui/home/widgets/date_bar.dart';
import 'package:sizer/sizer.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 16.sp),
              DateBarPicker(),
              SizedBox(height: 4.sp),
            ],
          ),
        ),
      ),
    );
  }
}
