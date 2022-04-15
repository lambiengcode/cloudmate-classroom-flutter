import 'package:cloudmate/src/helpers/date_time_helper.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class CustomDayPicker extends StatefulWidget {
  final initialDay;
  final initialMonth;
  final displayWeekdays;
  final isTheOtherPickerSelected;
  final version;
  final passedCurrentDate;
  final Function? handlePickerSelected;
  CustomDayPicker(
      {this.initialDay,
      this.passedCurrentDate,
      this.initialMonth,
      this.displayWeekdays = true,
      this.handlePickerSelected,
      this.isTheOtherPickerSelected = false,
      this.version = 2});

  @override
  _CustomDayPickerState createState() => _CustomDayPickerState();
}

class _CustomDayPickerState extends State<CustomDayPicker> {
  var currentDay;
  var currentMonth;
  var currentYear;
  var calendar;
  @override
  void initState() {
    super.initState();
    var currentTime = DateTime.now();
    currentMonth = widget.initialMonth == null ? currentTime.month : widget.initialMonth;
    currentYear = currentTime.year;
    calendar = dayToWeekday(month: currentMonth, year: currentYear);
    onDaySelected(currentTime.day);
  }

  onBackPressed() {
    var newCalendar;
    if (currentMonth == 1) {
      newCalendar = dayToWeekday(month: 12, year: currentYear - 1);
      setState(() {
        currentMonth = 12;
        currentYear = currentYear - 1;
        calendar = newCalendar;
      });
    } else {
      newCalendar = dayToWeekday(month: currentMonth - 1, year: currentYear);
      setState(() {
        currentMonth = currentMonth - 1;
        calendar = newCalendar;
      });
    }
  }

  onForwardPressed() {
    var newCalendar;
    if (currentMonth == 12) {
      newCalendar = dayToWeekday(month: 1, year: currentYear + 1);
      setState(() {
        currentMonth = 1;
        currentYear = currentYear + 1;
        calendar = newCalendar;
      });
    } else {
      newCalendar = dayToWeekday(month: currentMonth + 1, year: currentYear);
      setState(() {
        currentMonth = currentMonth + 1;
        calendar = newCalendar;
      });
    }
  }

  onDaySelected(day) {
    setState(() {
      currentDay = day;
    });
  }

  Color? setDayColor(index) {
    if (calendar[index] == currentDay) {
      return Colors.white;
    }
    return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.75);
  }

  Color setDayBorderColor(context, index) {
    if (calendar[index] == currentDay) {
      return Theme.of(context).primaryColor;
    } else if (calendar[index] == DateTime.now().day && currentMonth == DateTime.now().month) {
      return Color(0xFFDCE5EA);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => onBackPressed(),
                icon: Icon(
                  PhosphorIcons.caretLeft,
                  size: 20.sp,
                ),
              ),
              Text(
                'Tháng $currentMonth, $currentYear',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.25.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  onForwardPressed();
                },
                icon: Icon(
                  PhosphorIcons.caretRight,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          widget.displayWeekdays
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: dayNames
                        .map((e) => Flexible(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontFamily.lato,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!
                                          .withOpacity(.8),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                )
              : Container(),
          SizedBox(height: 10.sp),
          Container(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.6,
              ),
              shrinkWrap: true,
              itemCount: calendar.length,
              itemBuilder: (context, index) {
                if (calendar[index] == 0) {
                  return Container();
                }
                return GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      color: setDayBorderColor(context, index),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        calendar[index].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: setDayColor(index),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    onDaySelected(calendar[index]);
                    if (widget.handlePickerSelected != null) {
                      widget.handlePickerSelected!(
                        currentDay,
                        currentMonth,
                        currentYear,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
