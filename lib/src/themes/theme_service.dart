import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeOptions { light, dark }

class ThemeService extends ChangeNotifier {
  static ThemeOptions themeOptions = ThemeOptions.light;
  static ThemeMode currentTheme = ThemeMode.light;
  static final systemBrightness = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );
  final _getStorage = GetStorage();
  final storageKey = 'isDarkMode';

  switchStatusColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Platform.isIOS
          ? (isSavedDarkMode() ? Brightness.dark : Brightness.light)
          : (isSavedDarkMode() ? Brightness.light : Brightness.dark),
      statusBarIconBrightness: Platform.isIOS
          ? (isSavedDarkMode() ? Brightness.dark : Brightness.light)
          : (isSavedDarkMode() ? Brightness.light : Brightness.dark),
    ));
  }

  ThemeMode getThemeMode() {
    switchStatusColor();
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return _getStorage.read(storageKey) ?? false;
  }

  void saveThemeMode(bool isDarkMode) async {
    _getStorage.write(storageKey, isDarkMode);
  }

  void changeThemeMode() {
    saveThemeMode(!isSavedDarkMode());
    switchStatusColor();
    notifyListeners();
  }
}

ThemeService themeService = ThemeService();
