import 'dart:async';

import 'package:bloc/bloc.dart';
import 'bloc.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  AppStateBloc() : super(AppStateInitial());

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    if (event is OnResume) {
      yield Active();

      ///More Task
    }
    if (event is OnBackground) {
      yield Background();
    }
  }
}
