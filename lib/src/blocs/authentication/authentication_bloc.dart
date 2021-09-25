import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/routes/app_pages.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());

  final application = Application();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      _onAuthCheck(event);
    }

    if (event is OnAuthProcess) {
      _handlePressedLogin(event);
    }

    if (event is OnClear) {
      yield AuthenticationFail();
    }
  }

  Stream<AuthState> _onAuthCheck(OnAuthCheck event) async* {
    await Future.delayed(Duration(seconds: 1));
    yield AuthenticationFail();
  }

  Stream<AuthState> _handlePressedLogin(OnAuthProcess event) async* {
    print(event.username);
    yield AuthenticationSuccess();
    AppNavigator.pop();
  }
}
