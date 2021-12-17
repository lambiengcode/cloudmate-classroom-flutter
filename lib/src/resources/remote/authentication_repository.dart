import 'dart:async';

import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository {
  Future<String?> login(String username, String password, {String? token}) async {
    var body = {
      'username': username.toLowerCase(),
      'password': password,
    };
    Response response = await BaseRepository().postRoute(
      ApiGateway.LOGIN,
      body,
      token: token,
    );

    if (response.statusCode == 200) {
      if (token == null) {
        UserLocal().saveAccessToken(response.data['data']['token']);
      }
      return response.data['data']['token'];
    }
    return null;
  }

  Future<bool> register({
    required String fistName,
    required String lastName,
    required String username,
    required String password,
    String? token,
  }) async {
    var body = {
      'firstName': fistName,
      'lastName': lastName,
      'username': username.toLowerCase(),
      'password': password,
    };
    Response response = await BaseRepository().postRoute(
      ApiGateway.REGISTER,
      body,
      token: token,
    );

    if (response.statusCode == 200) {
      if (token == null) {
        UserLocal().saveAccessToken(response.data['data']['token']);
      }
      return true;
    }
    return false;
  }

  FutureOr<bool> logOut() async {
    UserLocal().clearAccessToken();
    return false;
  }
}
