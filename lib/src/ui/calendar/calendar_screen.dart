import 'package:cloudmate/src/ui/common/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';

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
