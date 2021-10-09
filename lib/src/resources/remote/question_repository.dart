import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class QuestionRepository {
  Future<QuestionModel?> createQuestion({
    required String question,
    required String examId,
    required List<String> answers,
    required List<int> corrects,
    required int duration,
  }) async {
    var body = {
      "question": question,
      "answers": answers,
      "correct": corrects,
      "duration": duration,
      "idSetOfQuestions": examId,
    };

    Response response = await BaseRepository().postRoute(ApiGateway.QUESTION, body);

    if ([200, 201].contains(response.statusCode)) {
      var jsonResponse = response.data['data'];
      return QuestionModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<QuestionModel>> getListQuestion({
    required int skip,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.QUESTION,
      query: 'skip=$skip',
    );
    print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => QuestionModel.fromMap(item)).toList();
    }

    return [];
  }

  Future<QuestionModel?> editQuestion({
    required String question,
    required String questionId,
    required List<String> answers,
    required List<int> correct,
    required int duration,
  }) async {
    var body = {
      "question": question,
      "answers": answers,
      "correct": correct,
      "duration": duration,
    };

    Response response = await BaseRepository().patchRoute(
      ApiGateway.QUESTION,
      query: 'id=$questionId',
      body: body,
    );

    if ([200, 201].contains(response.statusCode)) {
      var jsonResponse = response.data['data'];
      return QuestionModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<bool> deleteQuestion({
    required String questionId,
  }) async {
    Response response = await BaseRepository().deleteRoute(
      ApiGateway.QUESTION,
      query: 'status=0&id=$questionId',
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
