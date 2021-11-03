import 'package:cloudmate/src/ui/common/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
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
          padding: EdgeInsets.only(top: 4.sp),
          child: Column(
            children: [
              CustomDayPicker(
                handlePickerSelected: null,
                isTheOtherPickerSelected: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
