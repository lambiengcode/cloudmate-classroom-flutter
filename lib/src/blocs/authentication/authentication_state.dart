import 'package:cloudmate/src/models/user.dart';

abstract class AuthState {
  UserModel? userModel;
  AuthState({this.userModel});

  UserModel? get currentUser => this.userModel;

  set setCurrentUser(UserModel userModel) {
    this.userModel = userModel;
  }
}

class InitialAuthenticationState extends AuthState {}

class AuthenticationSuccess extends AuthState {}

class AuthenticationFail extends AuthState {}
