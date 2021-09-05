import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.appColors,
  });

  factory AppTheme.light() {
    final mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline1: TextStyle(color: appColors.header),
          headline2: TextStyle(color: appColors.header),
          bodyText1: TextStyle(color: appColors.contentText1),
        ),
        iconTheme: IconThemeData(
          color: appColors.contentText1,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: appColors.header),
        headline2: TextStyle(color: appColors.header),
        bodyText1: TextStyle(color: appColors.contentText1),
        bodyText2: TextStyle(color: appColors.contentText2),
      ),
      buttonColor: appColors.primary,
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    final mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline1: TextStyle(color: appColors.header),
          headline2: TextStyle(color: appColors.header),
          bodyText1: TextStyle(color: appColors.contentText1),
        ),
        iconTheme: IconThemeData(
          color: appColors.contentText1,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: appColors.header),
        headline2: TextStyle(color: appColors.header),
        bodyText1: TextStyle(color: appColors.contentText1),
        bodyText2: TextStyle(color: appColors.contentText2),
      ),
      buttonColor: appColors.primary,
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppColors appColors;
}
