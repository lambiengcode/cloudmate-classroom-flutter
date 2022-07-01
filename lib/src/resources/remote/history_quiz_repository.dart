import 'package:cloudmate/src/models/history_quiz_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class HistoryQuizRepository {
  Future<List<HistoryQuizModel>> getHistory({required String classId}) async {
    Response response =
        await BaseRepository().getRoute(ApiGateway.HISTORY, query: 'idClass=$classId');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      return data.map((e) => HistoryQuizModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<List<UserModel>> getDetailsHistory({required String quizId}) async {
    Response response =
        await BaseRepository().getRoute(ApiGateway.DETAIL_HISTORY, query: 'idQuizClass=$quizId');
        print(response.data.toString());
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      return data.where((e) => e['user'] != null).map((e) => UserModel.fromStatistic(e['user'], score: e['score'])).toList();
    }
    return [];
  }
}
