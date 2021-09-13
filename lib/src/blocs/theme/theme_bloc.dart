import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(InitialThemeState());

  @override
  Stream<ThemeState> mapEventToState(event) async* {
    if (event is OnChangeTheme) {
      yield ThemeUpdating();
      ThemeService.currentTheme = event.themeMode ?? ThemeService.currentTheme;
      ThemeService().changeThemeMode();
      yield ThemeUpdated();
    }
  }
}
