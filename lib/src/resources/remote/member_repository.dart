import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class MemberRepository {
  Future<List<UserModel>> getListMember({
    required int skip,
    required String id,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.QUESTION,
      query: 'skip=$skip&idSetOfQuestions=$id',
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => UserModel.fromMap(item)).toList();
    }

    return [];
  }

  Future<bool> removeMember({
    required String classId,
    required String memberId,
  }) async {
    return false;
  }
}
