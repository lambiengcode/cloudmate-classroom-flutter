import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/routes/app_pages.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());
  UserModel? userModel;

  final application = Application();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      yield await _onAuthCheck(event);
    }

    if (event is OnAuthProcess) {
      yield await _handlePressedLogin(event);
    }

    if (event is OnClear) {
      yield AuthenticationFail();
    }
  }

  Future<AuthState> _onAuthCheck(OnAuthCheck event) async {
    await Future.delayed(Duration(seconds: 1));
    return AuthenticationSuccess(userModel: userModel);
  }

  Future<AuthState> _handlePressedLogin(OnAuthProcess event) async {
    print(event.username);
    AppNavigator.pop();
    return AuthenticationSuccess(userModel: userModel);
  }
}
