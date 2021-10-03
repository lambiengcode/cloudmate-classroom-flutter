import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class UserRepository {
  Future<UserModel?> getInfoUser() async {
    Response response = await BaseRepository().getRoute(ApiGateway.GET_INFO);
    if (response.statusCode == 200) {
      return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  }
}
