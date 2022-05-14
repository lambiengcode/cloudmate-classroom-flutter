import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DotBelowDate extends StatelessWidget {
  final int quantity;
  const DotBelowDate({required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          quantity,
          (index) => Padding(
            padding: EdgeInsets.only(right: quantity == 1 || index == quantity - 1 ? 0 : 1.25.sp),
            child: Container(
              height: 2.sp,
              width: 2.sp,
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
