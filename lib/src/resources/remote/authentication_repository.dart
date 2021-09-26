import 'package:cloudmate/src/resources/api_gateway.dart';
import 'package:cloudmate/src/resources/handle_apis.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository {
  Future<bool> login(String username, String password) async {
    var body = {
      'username': username,
      'password': password,
    };
    Response response = await BaseRepository().postRoute(
      ApiGateway.LOGIN,
      body,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> register({
    required String fullName,
    required String phone,
    required String username,
    required String password,
  }) async {
    var body = {
      'fullName': fullName,
      'phone': phone,
      'username': username,
      'password': password,
    };
    Response response = await BaseRepository().postRoute(
      ApiGateway.REGISTER,
      body,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
