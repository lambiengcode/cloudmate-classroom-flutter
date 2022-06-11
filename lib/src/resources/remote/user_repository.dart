import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class UserRepository {
  Future<UserModel?> getInfoUser({String? token}) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.GET_INFO,
      token: token,
    );
    if (response.statusCode == 200) {
      return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  }

  Future<UserModel?> updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String intro,
  }) async {
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "intro": intro,
      "phone": phone,
    };

    Response response = await BaseRepository().patchRoute(ApiGateway.USER, body: body);

    print(response.data);

    if ([200, 201].contains(response.statusCode)) {
      return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  }

  Future<UserModel?> updateAvatar({
    required String avatar,
    required String blurHash,
  }) async {
    var body = {
      "blurHash": blurHash,
      "image": avatar,
    };
    Response response = await BaseRepository().patchRoute(ApiGateway.UPDATE_AVATAR, body: body);
    print(response.statusCode);
    print(response.data.toString());
    if ([200, 201].contains(response.statusCode)) {
      return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> deleteAccount() async {
    Response response = await BaseRepository().deleteRoute(ApiGateway.DELETE_ACCOUNT);
    print(response.statusCode);
    print(response.data.toString());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
