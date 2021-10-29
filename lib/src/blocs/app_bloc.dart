import 'package:cloudmate/src/blocs/authentication/authentication_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudmate/src/blocs/app_state/app_state_bloc.dart';
import 'package:cloudmate/src/blocs/application/application_bloc.dart';
import 'package:cloudmate/src/blocs/theme/theme_bloc.dart';

class AppBloc {
  static final appStateBloc = AppStateBloc();
  static final applicationBloc = ApplicationBloc();
  static final themeBloc = ThemeBloc();
  static final authBloc = AuthBloc();
  static final classBloc = ClassBloc();
  static final doExamBloc = DoExamBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<AppStateBloc>(
      create: (context) => appStateBloc,
    ),
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<ClassBloc>(
      create: (context) => classBloc,
    ),
    BlocProvider<DoExamBloc>(
      create: (context) => doExamBloc,
    ),
  ];

  static void dispose() {
    appStateBloc.close();
    applicationBloc.close();
    themeBloc.close();
    authBloc.close();
    classBloc.close();
    doExamBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
