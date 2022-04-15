part of sizer;

extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * SizerUtil.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * SizerUtil.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  // double get sp => this * (SizerUtil.width / 3) / 100;

  double get width {
    // DEVICE INCH
    double deviceSize = math.sqrt(100.h * 100.h + 100.w * 100.w) / Constants.INCH_TO_DP;
    if (deviceSize > 6.5) {
      return 65.w * (6.5 / deviceSize);
    } else if (deviceSize > 5.5) {
      return 100.w;
    } else if (deviceSize > 5.0) {
      return 90.w;
    } else {
      return 85.w;
    }
  }

  bool get isTablet {
    // DEVICE INCH
    double deviceSize = math.sqrt(100.h * 100.h + 100.w * 100.w) / Constants.INCH_TO_DP;
    if (deviceSize > 6.5) {
      return true;
    }

    return false;
  }

  double get sp => this * (width / 3) / 100;

  int get itemCountGridViewCalendar {
    return (100.w / (150.sp)).round();
  }

  int get itemCountGridViewMoney {
    return (100.w / (100.sp)).round();
  }
}
