abstract class AuthEvent {}

class OnAuthCheck extends AuthEvent {}

class OnAuthProcess extends AuthEvent {
  final String username;
  final String password;
  OnAuthProcess({required this.username, required this.password});
}

class OnClear extends AuthEvent {}
