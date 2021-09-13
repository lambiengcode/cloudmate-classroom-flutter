import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class OnChangeTheme extends ThemeEvent {
  final ThemeMode? themeMode;

  OnChangeTheme({
    this.themeMode,
  });
}
