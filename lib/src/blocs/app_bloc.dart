import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_2school/src/blocs/app_state/app_state_bloc.dart';

class AppBloc {
  static final appStateBloc = AppStateBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<AppStateBloc>(
      create: (context) => appStateBloc,
    ),
  ];

  static void dispose() {
    appStateBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
