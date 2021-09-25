import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class InitialTheme extends ThemeEvent {
  final ThemeMode? themeMode;

  InitialTheme({
    this.themeMode,
  });
}

class OnChangeTheme extends ThemeEvent {
  final ThemeMode? themeMode;

  OnChangeTheme({
    this.themeMode,
  });
}
