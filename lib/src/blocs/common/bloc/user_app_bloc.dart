import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_app_event.dart';
part 'user_app_state.dart';

class UserAppBloc extends Bloc<UserAppEvent, UserAppState> {
  UserAppBloc() : super(UserAppInitial());

  @override
  Stream<UserAppState> mapEventToState(
    UserAppEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
