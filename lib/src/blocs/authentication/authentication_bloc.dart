import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:cloudmate/src/resources/remote/authentication_repository.dart';
import 'package:cloudmate/src/resources/remote/user_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());
  UserModel? userModel;

  final application = Application();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      bool isLogined = await _onAuthCheck();
      if (isLogined) {
        yield AuthenticationSuccess();
      } else {
        yield AuthenticationFail();
      }
    }

    if (event is OnClear) {
      yield AuthenticationSuccess(
        userModel: userModel,
      );
    }

    if (event is LoginEvent) {
      bool isSuccess = await _handleLogin(event);
      AppNavigator.pop();
      if (isSuccess) {
        yield AuthenticationSuccess(
          userModel: userModel,
        );
      } else {
        yield AuthenticationFail();
      }
    }

    if (event is RegisterEvent) {
      bool isSuccess = await _handleRegister(event);
      AppNavigator.pop();
      if (isSuccess) {
        yield AuthenticationSuccess(
          userModel: userModel,
        );
      } else {
        yield AuthenticationFail();
      }
    }

    if (event is LogOutEvent) {
      bool isSuccess = await _handleLogOut();
      if (isSuccess) {
        yield AuthenticationFail();
      }
    }

    if (event is GetInfoUser) {
      await _handleGetUserInfo();
      yield AuthenticationSuccess(
        userModel: userModel,
      );
    }
  }

  Future<bool> _onAuthCheck() async {
    return UserLocal().getAccessToken() != '';
  }

  Future<bool> _handleLogin(LoginEvent event) async {
    bool isSuccess = await AuthenticationRepository().login(
      event.username,
      event.password,
    );

    return isSuccess;
  }

  Future<bool> _handleRegister(RegisterEvent event) async {
    bool isSuccess = await AuthenticationRepository().register(
      fistName: event.firstName,
      lastName: event.lastName,
      username: event.username,
      password: event.password,
    );

    return isSuccess;
  }

  Future<bool> _handleLogOut() async {
    await AuthenticationRepository().logOut();
    return true;
  }

  Future<void> _handleGetUserInfo() async {
    UserModel? user = await UserRepository().getInfoUser();
    userModel = user;
  }
}
