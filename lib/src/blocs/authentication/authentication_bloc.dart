import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/configs/application.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());

  final application = Application();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      await Future.delayed(Duration(seconds: 2));
      yield AuthenticationFail();
    }

    if (event is OnAuthProcess) {
      yield AuthenticationSuccess();
    }

    if (event is OnClear) {
      ///Delete user
      yield AuthenticationFail();
    }
  }
}
