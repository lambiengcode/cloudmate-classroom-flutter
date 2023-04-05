import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DateBarPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DateBarPickerState();
}

class _DateBarPickerState extends State<DateBarPicker> {
  List<String> values = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  int currentPicked = 0;
  pickDay(index) {
    setState(() {
      currentPicked = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAction(context, 0),
          _buildAction(context, 1),
          _buildAction(context, 2),
          _buildAction(context, 3),
          _buildAction(context, 4),
          _buildAction(context, 5),
          _buildAction(context, 6),
        ],
      ),
    );
  }

  Widget _buildAction(context, index) {
    return GestureDetector(
      onTap: () => pickDay(index),
      child: Container(
        height: 32.sp,
        width: 32.sp,
        alignment: Alignment.center,
        decoration: currentPicked == index
            ? AppDecoration.buttonActionCircleActive(context).decoration
            : AppDecoration.buttonActionCircle(context).decoration,
        child: Text(
          values[index],
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 9.5.sp,
                fontWeight: currentPicked == index ? FontWeight.bold : FontWeight.w500,
                color: currentPicked == index
                    ? colorPrimary
                    : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(
                          ThemeService().isSavedDarkMode() ? .88 : .65,
                        ),
              ),
        ),
      ),
    );
  }
}
