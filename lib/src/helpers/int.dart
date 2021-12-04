import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:flutter/material.dart';

extension IntHelper on int {
  String formatTwoDigits() {
    Duration duration = Duration(seconds: this);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Color getColorByPing() {
    if (this < 200) {
      return colorActive;
    } else if (this < 400) {
      return colorMedium;
    } else {
      return colorHigh;
    }
  }

  String getRoleName() {
    switch (this) {
      case 0:
        return "Thành viên";
      case 1:
        return "Admin";
      default:
        return "Quản lí";
    }
  }
}
