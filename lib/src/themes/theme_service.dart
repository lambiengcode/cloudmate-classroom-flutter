import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeOptions { light, dark }

class ThemeService extends ChangeNotifier {
  static ThemeOptions themeOptions = ThemeOptions.light;
  static ThemeMode currentTheme = ThemeMode.light;
  final _getStorage = GetStorage();
  final storageKey = 'isDarkMode';
  bool isDarkMode = false;

  switchStatusColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          isSavedDarkMode() ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          isSavedDarkMode() ? Brightness.light : Brightness.dark,
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
    isDarkMode = !isDarkMode;
    switchStatusColor();
    saveThemeMode(!isSavedDarkMode());
    notifyListeners();
  }

  void initThemeMode() {
    if (isSavedDarkMode()) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
  }
}

ThemeService themeService = ThemeService();
