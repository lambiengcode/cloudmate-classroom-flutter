import 'package:cloudmate/src/models/user.dart';

abstract class AuthState {}

class InitialAuthenticationState extends AuthState {}

class AuthenticationSuccess extends AuthState {
  UserModel? userModel;
  AuthenticationSuccess({this.userModel});
}

class AuthenticationFail extends AuthState {}

class Authenticating extends AuthState {}
